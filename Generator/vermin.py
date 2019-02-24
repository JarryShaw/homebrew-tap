# -*- coding: utf-8 -*-

import hashlib
import re
import subprocess

import bs4
import requests

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
        VERMIN_URL = link
        VERMIN_SHA = hashlib.sha256(requests.get(VERMIN_URL).content).hexdigest()
        break

FORMULA = f'''\
class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "{VERMIN_URL}"
  sha256 "{VERMIN_SHA}"

  head "https://github.com/netromdk/vermin.git", :branch => "master"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    path = Pathname.glob(libexec/"lib/python?.?/site-packages/vermin")[0]
    assert_match "Minimum required versions: 2.7, 3.0", shell_output("#{bin}/vermin -q #{path}")
  end
end
'''

with open('../Formula/vermin.rb', 'w') as file:
    file.write(FORMULA)
