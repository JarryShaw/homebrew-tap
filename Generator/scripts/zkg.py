# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess  # nosec: B404
import sys
from typing import TYPE_CHECKING

import requests

if TYPE_CHECKING:
    VERSION: str

subprocess.check_call(['pip', 'install', 'zkg'])  # nosec: B603 B607

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec: B603 B607
    match = re.match(r"zkg==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

ZKG_URL = f'https://github.com/zeek/package-manager/archive/v{VERSION}.tar.gz'
ZKG_SHA = hashlib.sha256(requests.get(ZKG_URL).content).hexdigest()

_data_pkgs = {}  # type: dict[str, dict]


def _fetch_dependency(package: 'str') -> 'dict[str, dict]':
    dependencies = _data_pkgs.get(package)
    if dependencies is not None:
        return dependencies

    argv = [sys.executable, '-m', 'pip', 'show', package]

    _deps_pkgs = {}
    requirements = set()  # type: set[str]
    for line in subprocess.check_output(argv).decode().strip().splitlines():  # nosec: B603 B607; pylint: disable=redefined-outer-name
        match = re.match(r"Requires: (.*)", line)  # pylint: disable=redefined-outer-name
        if match is not None:
            requirements = set(match.groups()[0].split(', '))
            break

    for item in filter(None, requirements):
        _deps_pkgs[item] = _fetch_dependency(item)
    _data_pkgs.update(_deps_pkgs)

    return _deps_pkgs


def _list_dependency(dependencies: 'dict[str, dict]') -> 'list[str]':
    _list_pkgs = []
    for package, deps_pkgs in dependencies.items():
        _list_pkgs.append(package)
        _list_pkgs.extend(_list_dependency(deps_pkgs))
    return _list_pkgs


_deps_list = _list_dependency(_fetch_dependency('zkg'))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
ZKG = subprocess.check_output(args).decode().strip()  # nosec: B603 B607

FORMULA = f'''\
class Zkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "{ZKG_URL}"
  sha256 "{ZKG_SHA}"

  head "https://github.com/zeek/package-manager.git", branch: "master"

  depends_on "homebrew/core/python@3.9"
  depends_on "homebrew/core/zeek"

  {ZKG}

  def install
    virtualenv_install_with_resources
  end

  # def post_install
  #   system bin/"zkg", "autoconfig"
  # end

  def caveats
    <<~EOS
      zkg has been installed as
        #{{HOMEBREW_PREFIX}}/bin/zkg

      To perform postinstall process, please directly call the
      following command: `zkg autoconfig`.

      Configuration file locates at ~/.zkg/config, please
      run `zkg config` command to set up your runtime
      specifications.

      For more information, check out `zkg --help` command.
      Online documentations available at GitHub repository.

      See: https://docs.zeek.org/projects/package-manager
    EOS
  end

  test do
    system bin/"zkg", "--help"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w', encoding='utf-8') as file:
    file.write(FORMULA)

subprocess.check_call(['pip-autoremove', '-y', 'zkg'])  # nosec: B603 B607
