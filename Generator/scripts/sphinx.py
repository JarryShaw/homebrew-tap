# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess  # nosec: B404
import sys
from typing import TYPE_CHECKING

# import bs4
import requests

if TYPE_CHECKING:
    VERSION: str

subprocess.check_call(['pip', 'install', 'sphinx', 'sphinx-autobuild', 'sphinx-autodoc-typehints'])  # nosec: B603 B607

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec: B603 B607
    match = re.match(r"Sphinx==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

SPHINX_URL = f'https://github.com/sphinx-doc/sphinx/archive/v{VERSION}.tar.gz'
SPHINX_SHA = hashlib.sha256(requests.get(SPHINX_URL).content).hexdigest()
# url = f'https://pypi.org/project/Sphinx/{VERSION}/#files'
# page = requests.get(url)
# soup = bs4.BeautifulSoup(page.text, 'html5lib')
# table = soup.find_all('table', class_='table--downloads')[0]

# for line in filter(lambda item: isinstance(item, bs4.element.Tag), table.tbody):
#     item = line.find_all('td')[0]
#     link = item.a.get('href') or ''
#     if link.endswith('.tar.gz'):
#         SPHINX_URL = link
#         SPHINX_SHA = hashlib.sha256(requests.get(SPHINX_URL).content).hexdigest()
#         break

bottle = []
bottle_flag = False

formula = subprocess.check_output(['brew', 'formula', 'sphinx-doc']).decode().strip()  # nosec: B603 B607
with open(formula, encoding='utf-8') as file:
    for line in file:
        if bottle_flag:
            bottle.append(line)
            if line.strip() == 'end':
                break
        elif line.strip() == 'bottle do':
            bottle.append(line)
            bottle_flag = True
BOTTLE = ''.join(bottle).strip()

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

    for item in filter(None, requirements):  # pylint: disable=redefined-outer-name
        _deps_pkgs[item] = _fetch_dependency(item)
    _data_pkgs.update(_deps_pkgs)

    return _deps_pkgs


def _list_dependency(dependencies: 'dict[str, dict]') -> 'list[str]':
    _list_pkgs = []
    for package, deps_pkgs in dependencies.items():
        _list_pkgs.append(package)
        _list_pkgs.extend(_list_dependency(deps_pkgs))
    return _list_pkgs


_deps_list = ['sphinx-autobuild']
_deps_list.extend(_list_dependency(_fetch_dependency('Sphinx')))
_deps_list.extend(_list_dependency(_fetch_dependency('sphinx-autobuild')))
_deps_list.extend(_list_dependency(_fetch_dependency('sphinx-autodoc-typehints')))
#_deps_list.remove('setuptools')

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
temp = subprocess.check_output(args).decode().strip()  # nosec: B603 B607

st_flag = False
SPHINX = ''
for line in temp.splitlines(True):
    if line.strip() == 'resource "setuptools" do':
        st_flag = True
        continue

    if st_flag:
        if line.strip() == 'end':
            st_flag = False
        continue

    SPHINX += line
SPHINX = 'end\n\n'.join(map(lambda s: s.strip('\n'), SPHINX.split('end'))).strip()

FORMULA = f'''\
class Sphinx < Formula
  include Language::Python::Virtualenv

  desc "Tool to create intelligent and beautiful documentation"
  homepage "https://www.sphinx-doc.org/"
  url "{SPHINX_URL}"
  sha256 "{SPHINX_SHA}"

  {BOTTLE}

  depends_on "homebrew/core/python@3.9"

  conflicts_with "homebrew/core/sphinx-doc", because: "this is a port of sphinx-doc from homebrew-core"

  {SPHINX}

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"sphinx-quickstart", "-pProject", "-aAuthor", "-v1.0", "-q", testpath
    system bin/"sphinx-build", testpath, testpath/"build"
    assert_predicate testpath/"build/index.html", :exist?
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w', encoding='utf-8') as file:
    file.write(FORMULA)

subprocess.check_call(['pip-autoremove', '-y', 'sphinx', 'sphinx-autobuild', 'sphinx-autodoc-typehints'])  # nosec: B603 B607
