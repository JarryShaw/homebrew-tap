# -*- coding: utf-8 -*-

import hashlib
import re
import subprocess

import bs4
import requests

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"PyInstaller==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

url = f'https://pypi.org/project/PyInstaller/{VERSION}/#files'
page = requests.get(url)
soup = bs4.BeautifulSoup(page.text, 'html5lib')
table = soup.find_all('table', class_='table--downloads')[0]

for line in filter(lambda item: isinstance(item, bs4.element.Tag), table.tbody):
    item = line.find_all('td')[0]
    link = item.a.get('href') or ''
    if link.endswith('.tar.gz'):
        PYINSTALLER_URL = link
        PYINSTALLER_SHA = hashlib.sha256(requests.get(PYINSTALLER_URL).content).hexdigest()
        break

ALTGRAPH = subprocess.check_output(['poet', 'altgraph']).decode().strip()
MACHOLIB = subprocess.check_output(['poet', 'macholib']).decode().strip()
PEFILE = subprocess.check_output(['poet', 'pefile']).decode().strip()

FORMULA = f'''\
class Pyinstaller < Formula
  include Language::Python::Virtualenv

  desc "Bundle a Python application and all its dependencies"
  homepage "https://www.pyinstaller.org"
  url "{PYINSTALLER_URL}"
  sha256 "{PYINSTALLER_SHA}"

  head "https://github.com/pyinstaller/pyinstaller.git", :branch => "develop"

  depends_on "python"

  conflicts_with "pyinstaller", :because => "it is now integrated with homebrew-core"

  {ALTGRAPH}

  {MACHOLIB}

  {PEFILE}

  def install
    virtualenv_install_with_resources
  end

  test do
    xy = Language::Python.major_minor_version "python3"
    system bin/"pyinstaller", "-F", "--distpath=#{{testpath}}/dist", "--workpath=#{{testpath}}/build", libexec/"lib/python#{{xy}}/site-packages/easy_install.py"
    assert_predicate testpath/"dist/easy_install", :exist?
  end
end
'''

with open('../Formula/pyinstaller.rb', 'w') as file:
    file.write(FORMULA)
