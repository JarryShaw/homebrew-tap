# -*- coding: utf-8 -*-

import os
import re
import subprocess  # nosec: B404
import sys
import typing

import pypi_simple

if typing.TYPE_CHECKING:
    VERSION = ''
for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec: B603,B607
    match = re.match(r"snooty-lextudio==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

with pypi_simple.PyPISimple() as client:
    snooty_page = client.get_project_page('snooty-lextudio')  # type: pypi_simple.ProjectPage # type: ignore[assignment]
snooty_pkg = snooty_page.packages[0]

SNOOTY_URL = snooty_pkg.url
SNOOTY_SHA = snooty_pkg.get_digests()['sha256']

_data_pkgs = dict()  # type: ignore


def _fetch_dependency(package):
    dependencies = _data_pkgs.get(package)
    if dependencies is not None:
        return dependencies

    argv = [sys.executable, '-m', 'pip', 'show', package]

    _deps_pkgs = dict()
    requirements = set()
    for line in subprocess.check_output(argv).decode().strip().splitlines():  # nosec  # pylint: disable=redefined-outer-name
        match = re.match(r"Requires: (.*)", line)  # pylint: disable=redefined-outer-name
        if match is not None:
            requirements = set(match.groups()[0].split(', '))
            break

    for item in filter(None, requirements):
        _deps_pkgs[item] = _fetch_dependency(item)
    _data_pkgs.update(_deps_pkgs)

    return _deps_pkgs


def _list_dependency(dependencies):
    _list_pkgs = list()
    for package, deps_pkgs in dependencies.items():
        _list_pkgs.append(package)
        _list_pkgs.extend(_list_dependency(deps_pkgs))
    return _list_pkgs


_deps_list = _list_dependency(_fetch_dependency('snooty-lextudio'))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
SNOOTY = subprocess.check_output(args).decode().strip()  # nosec

FORMULA = f'''\
class SnootyLextudio < Formula
  include Language::Python::Virtualenv

  desc "Visual Studio Code language server for reStructureText"
  homepage "https://github.com/vscode-restructuredtext/snooty-parser"
  url "{SNOOTY_URL}"
  sha256 "{SNOOTY_SHA}"

  head "https://github.com/vscode-restructuredtext/snooty-parser.git", branch: "master"

  depends_on "homebrew/core/python"

  {SNOOTY}

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"snooty", "--help"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
