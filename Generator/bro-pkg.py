# -*- coding: utf-8 -*-

# -*- coding: utf-8 -*-

import hashlib
import re
import subprocess
import sys

import bs4
import requests

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"bro-pkg==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

BROPKG_URL = f'https://github.com/zeek/package-manager/archive/v{VERSION}.tar.gz'
BROPKG_SHA = hashlib.sha256(requests.get(BROPKG_URL).content).hexdigest()

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


_deps_list = _list_dependency(_fetch_dependency('bro-pkg'))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
BROPKG = subprocess.check_output(args).decode().strip()

FORMULA = f'''\
class BroPkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "{BROPKG_URL}"
  sha256 "{BROPKG_SHA}"

  head "https://github.com/zeek/package-manager.git", :branch => "master"

  depends_on "bro"
  depends_on "python"

  {BROPKG}

  def install
    virtualenv_install_with_resources
  end

  # def post_install
  #   system bin/"bro-pkg", "autoconfig"
  # end

  def caveats
    text = <<~EOS
      bro-pkg has been installed as
        #{{HOMEBREW_PREFIX}}/bin/bro-pkg

      To perform postinstall process, please directly call the
      following command: `bro-pkg autoconfig`.

      Configuration file locates at ~/.bro-pkg/config, please
      run `bro-pkg config` command to set up your runtime
      specifications.

      For more information, check out `bro-pkg --help` command.
      Online documentations available at GitHub repository.

      See: https://docs.zeek.org/projects/package-manager
    EOS
    text
  end

  test do
    system bin/"bro-pkg", "--help"
  end
end
'''

with open('../Formula/bro-pkg.rb', 'w') as file:
    file.write(FORMULA)
