# -*- coding: utf-8 -*-

import os
import subprocess
import time

import pkg_resources

VERSION = pkg_resources.parse_version(time.strftime('%Y.%m.%d'))

CERTIFI = subprocess.check_output(['poet', 'certifi']).decode().strip() \
    .replace('https://files.pythonhosted.org', 'https://pypi.tuna.tsinghua.edu.cn')
CHARDET = subprocess.check_output(['poet', 'chardet']).decode().strip() \
    .replace('https://files.pythonhosted.org', 'https://pypi.tuna.tsinghua.edu.cn')
IDNA = subprocess.check_output(['poet', 'idna']).decode().strip() \
    .replace('https://files.pythonhosted.org', 'https://pypi.tuna.tsinghua.edu.cn')
REQUESTS = subprocess.check_output(['poet', 'requests']).decode().strip() \
    .replace('https://files.pythonhosted.org', 'https://pypi.tuna.tsinghua.edu.cn')
URLLIB3 = subprocess.check_output(['poet', 'urllib3']).decode().strip() \
    .replace('https://files.pythonhosted.org', 'https://pypi.tuna.tsinghua.edu.cn')

FORMULA = f'''\
class Pydl < Formula
  include Language::Python::Virtualenv

  desc "Video downloader powered by jarryshaw.me"
  homepage "https://jarryshaw.me"
  url "https://github.com/JarryShaw/pydl.git"
  version "{VERSION}"

  depends_on "homebrew/core/aria2"
  depends_on "homebrew/core/python@3.9"

  {CERTIFI}

  {CHARDET}

  {IDNA}

  {REQUESTS}

  {URLLIB3}

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dl-add", "--help"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
