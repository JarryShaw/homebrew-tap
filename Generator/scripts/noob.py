# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/zmwangx/homebrew-npm-noob/master/Formula/noob.rb

import hashlib
import os
import re
import subprocess
import sys

import requests

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"homebrew-npm-noob==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

NOOB_URL = f'https://github.com/zmwangx/homebrew-npm-noob/archive/v{VERSION}.tar.gz'
NOOB_SHA = hashlib.sha256(requests.get(NOOB_URL).content).hexdigest()

_data_pkgs = dict()


def _fetch_dependency(package):
    dependencies = _data_pkgs.get(package)
    if dependencies is not None:
        return dependencies

    argv = [sys.executable, '-m', 'pip', 'show', package]

    _deps_pkgs = dict()
    requirements = set()
    for line in subprocess.check_output(argv).decode().strip().splitlines():
        match = re.match(r"Requires: (.*)", line)
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


_deps_list = _list_dependency(_fetch_dependency('homebrew-npm-noob'))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
NOOB = subprocess.check_output(args).decode().strip()

FORMULA = f'''\
class Noob < Formula
  include Language::Python::Virtualenv

  desc "Generate Homebrew formulae for npm packages"
  homepage "https://github.com/zmwangx/homebrew-npm-noob"
  url "{NOOB_URL}"
  sha256 "{NOOB_SHA}"

  head "https://github.com/zmwangx/homebrew-npm-noob.git", :branch => "master"

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
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
