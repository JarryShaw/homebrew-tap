# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/zmwangx/homebrew-npm-noob/master/Formula/noob.rb

import hashlib
import os
import re
import subprocess  # nosec: B404
import sys
from typing import TYPE_CHECKING

import requests

if TYPE_CHECKING:
    VERSION: str

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec: B603 B607
    match = re.match(r"homebrew-npm-noob==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

NOOB_URL = f'https://github.com/zmwangx/homebrew-npm-noob/archive/v{VERSION}.tar.gz'
NOOB_SHA = hashlib.sha256(requests.get(NOOB_URL).content).hexdigest()

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


_deps_list = _list_dependency(_fetch_dependency('homebrew-npm-noob'))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
NOOB = subprocess.check_output(args).decode().strip()  # nosec: B603 B607

FORMULA = f'''\
class Noob < Formula
  include Language::Python::Virtualenv

  desc "Generate Homebrew formulae for npm packages"
  homepage "https://github.com/zmwangx/homebrew-npm-noob"
  url "{NOOB_URL}"
  sha256 "{NOOB_SHA}"

  head "https://github.com/zmwangx/homebrew-npm-noob.git", branch: "master"

  depends_on "homebrew/core/python"

  {NOOB}

  def install
    virtualenv_install_with_resources
    man1.install "docs/noob.1"
  end

  test do
    assert_match "class Svgo < Formula", shell_output("#{{bin}}/noob svgo")
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w', encoding='utf-8') as file:
    file.write(FORMULA)
