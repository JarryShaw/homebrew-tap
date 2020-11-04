# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess
import sys

import requests

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"dmgbuild==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

DMGBUILD_URL = f'https://github.com/al45tair/dmgbuild/archive/v{VERSION}.tar.gz'
DMGBUILD_SHA = hashlib.sha256(requests.get(DMGBUILD_URL).content).hexdigest()

_data_pkgs = dict()


def _fetch_dependency(package):
    dependencies = _data_pkgs.get(package)
    if dependencies is not None:
        return dependencies

    argv = [sys.executable, '-m', 'pip', 'show', package]

    _deps_pkgs = dict()
    requirements = set()
    for line in subprocess.check_output(argv).decode().strip().splitlines():  # pylint: disable=redefined-outer-name
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


_deps_list = _list_dependency(_fetch_dependency('dmgbuild'))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
DMGBUILD = subprocess.check_output(args).decode().strip()

FORMULA = f'''\
class Dmgbuild < Formula
  include Language::Python::Virtualenv

  desc "macOS command-line utility to build disk images"
  homepage "https://github.com/al45tair/dmgbuild"
  url "{DMGBUILD_URL}"
  sha256 "{DMGBUILD_SHA}"

  head "https://github.com/al45tair/dmgbuild.git", :branch => "master"

  depends_on "homebrew/core/python@3.9"

  {DMGBUILD}

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dmgbuild", "--help"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
