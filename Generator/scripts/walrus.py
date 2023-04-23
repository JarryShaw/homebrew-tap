# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess  # nosec: B404
from typing import TYPE_CHECKING

import requests

# with open(os.path.expanduser('~/GitHub/walrus/walrus.py'), 'r') as file:
#     for line in file:
#         match = re.match(r"^__version__ = '(.*)'", line)
#         if match is None:
#             continue
#         VERSION = match.groups()[0]
#         break
# # print(VERSION)
if TYPE_CHECKING:
    VERSION: str

subprocess.check_call(['pip', 'install', 'bpc-walrus'])  # nosec: B603 B607

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec: B603 B607
    match = re.match(r"bpc-walrus==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

WALRUS_URL = f'https://github.com/pybpc/walrus/archive/v{VERSION}.tar.gz'
WALRUS_SHA = hashlib.sha256(requests.get(WALRUS_URL).content).hexdigest()
# print(WALRUS_URL)
# print(WALRUS_SHA)

PARSO = subprocess.check_output(['poet', 'parso']).decode().strip()  # nosec: B603 B607
TBTRIM = subprocess.check_output(['poet', 'tbtrim']).decode().strip()  # nosec: B603 B607
BPC_UTILS = subprocess.check_output(['poet', 'bpc-utils']).decode().strip()  # nosec: B603 B607
# print(PARSO)
# print(TBTRIM)

match = re.match(r'([0-9.]+)\.post([0-9])', VERSION)
if match is None:
    WALRUS = (f'url "{WALRUS_URL}"\n'
              f'  sha256 "{WALRUS_SHA}"')
else:
    version, subversion = match.groups()
    revision = chr(96 + int(subversion))  # ord('a') -> 97
    WALRUS = (f'url "{WALRUS_URL}"\n'
              f'  version "{version}{revision}"\n'
              f'  sha256 "{WALRUS_SHA}"')


FORMULA = f'''\
class Walrus < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 assignment expressions"
  homepage "https://github.com/pybpc/walrus#walrus"
  {WALRUS}

  head "https://github.com/pybpc/walrus.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  {BPC_UTILS}

  {PARSO}

  {TBTRIM}

  def install
    virtualenv_install_with_resources

    man1.install "share/walrus.1"
    bash_completion.install "share/walrus.bash-completion"
  end

  test do
    (testpath/"test.py").write <<~EOS
      a = (b := 1)
      print(a, b)
    EOS

    std_output = <<~EOS
      1 1
    EOS

    system bin/"walrus", "--no-archive", "test.py"
    assert_match std_output, shell_output("#{{Formula["python3"].bin}}/python test.py")
  end
end
'''

if os.path.basename(__file__) == 'setup-formula.py':
    repo_root = subprocess.check_output(['brew', '--repository', 'jarryshaw/tap'],   # nosec: B603 B607
                                        encoding='utf-8').strip()
    formula = os.path.join(repo_root, 'Formula', 'walrus.rb')
else:
    formula = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                           f'{os.path.splitext(os.path.basename(__file__))[0]}.rb')
with open(formula, 'w', encoding='utf-8') as file:
    file.write(FORMULA)

subprocess.check_call(['pip-autoremove', '-y', 'bpc-walrus'])  # nosec: B603 B607
