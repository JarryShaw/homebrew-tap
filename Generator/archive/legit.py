# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess

import bs4
import requests

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"legit==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

url = f'https://pypi.org/project/legit/{VERSION}/#files'
page = requests.get(url)
soup = bs4.BeautifulSoup(page.text, 'html5lib')
table = soup.find_all('table', class_='table--downloads')[0]

for line in filter(lambda item: isinstance(item, bs4.element.Tag), table.tbody):
    item = line.find_all('td')[0]
    link = item.a.get('href') or ''
    # print(link)
    if link.endswith('.tar.gz'):
        LEGIT_URL = link
        LEGIT_SHA = hashlib.sha256(requests.get(LEGIT_URL).content).hexdigest()
        break

CRAYONS = subprocess.check_output(['poet', 'crayons']).decode().strip()
SIX = subprocess.check_output(['poet', 'six']).decode().strip()
PACKAGING = subprocess.check_output(['poet', 'packaging']).decode().strip()
SMMAP2 = subprocess.check_output(['poet', 'smmap2']).decode().strip()
PYPARSING = subprocess.check_output(['poet', 'pyparsing']).decode().strip()
ARGS = subprocess.check_output(['poet', 'args']).decode().strip()
GITPYTHON = subprocess.check_output(['poet', 'GitPython']).decode().strip()
APPDIRS = subprocess.check_output(['poet', 'appdirs']).decode().strip()
GITDB2 = subprocess.check_output(['poet', 'gitdb2']).decode().strip()
CLINT = subprocess.check_output(['poet', 'clint']).decode().strip()
CLICK = subprocess.check_output(['poet', 'click']).decode().strip()

FORMULA = f'''\
class Legit < Formula
  include Language::Python::Virtualenv

  desc "Git for Humans"
  homepage "http://www.git-legit.org"
  url "{LEGIT_URL}"
  sha256 "{LEGIT_SHA}"

  depends_on "python"

  {CRAYONS}

  {SIX}

  {PACKAGING}

  {SMMAP2}

  {PYPARSING}

  {ARGS}

  {GITPYTHON}

  {APPDIRS}

  {GITDB2}

  {CLINT}

  {CLICK}

  def install
    virtualenv_install_with_resources
  end

  def caveat
    text <<~EOS
      Legit has been installed as
        #{{HOMEBREW_PREFIX}}/bin/legit

      To view usage and examples, run legit with no commands or options:
      $ legit install

      To install the git aliases, run the following command:
      $ legit --install

      To uninstall the git aliases, run the following command:
      $ legit --uninstall
    EOS
    text
  end

  test do
    chdir(testpath) do
      system "git", "init"
      assert_match "No branches available", shell_output("#{{bin}}/legit branches")
    end
  end
end
'''

with open('../Formula/legit.rb', 'w') as file:
    file.write(FORMULA)
