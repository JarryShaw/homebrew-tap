# -*- coding: utf-8 -*-

import hashlib
import re
import subprocess
import sys

import bs4
import requests

formula = subprocess.check_output(['brew', 'formula', 'sphinx-doc']).decode().strip()

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"Sphinx==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

url = f'https://pypi.org/project/Sphinx/{VERSION}/#files'
page = requests.get(url)
soup = bs4.BeautifulSoup(page.text, 'html5lib')
table = soup.find_all('table', class_='table--downloads')[0]

for line in filter(lambda item: isinstance(item, bs4.element.Tag), table.tbody):
    item = line.find_all('td')[0]
    link = item.a.get('href') or ''
    if link.endswith('.tar.gz'):
        SPHINX_URL = link
        SPHINX_SHA = hashlib.sha256(requests.get(SPHINX_URL).content).hexdigest()
        break

bottle = list()
bottle_flag = False
with open(formula) as file:
    for line in file:
        if line == '  end\n':
            bottle.append(line)
            break
        elif bottle_flag:
            bottle.append(line)
        elif line == '  bottle do\n':
            bottle.append(line)
            bottle_flag = True
BOTTLE = ''.join(bottle).strip()


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


_data_pkgs = dict()
_deps_list = ['sphinx-autobuild']
_deps_list.extend(_list_dependency(_fetch_dependency('Sphinx')))
_deps_list.extend(_list_dependency(_fetch_dependency('sphinx-autobuild')))

args = ['poet', '--single']
args.extend(sorted(set(_deps_list)))
SPHINX = subprocess.check_output(args).decode().strip()

FORMULA = f'''\
class SphinxDoc < Formula
  include Language::Python::Virtualenv

  desc "Tool to create intelligent and beautiful documentation"
  homepage "https://www.sphinx-doc.org/"
  url "{SPHINX_URL}"
  sha256 "{SPHINX_SHA}"

  {BOTTLE}

  depends_on "python"

  conflicts_with "sphinx-doc", :because => "this is a port of sphinx-doc from homebrew-core"

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

with open('../Formula/sphinx.rb', 'w') as file:
    file.write(FORMULA)
