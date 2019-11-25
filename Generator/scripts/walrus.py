# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess

import requests

with open(os.path.expanduser('~/GitHub/walrus/walrus.py'), 'r') as file:
    for line in file:
        match = re.match(r"^__version__ = '(.*)'", line)
        if match is None:
            continue
        VERSION = match.groups()[0]
        break
# print(VERSION)

WALRUS_URL = f'https://github.com/JarryShaw/walrus/archive/v{VERSION}.tar.gz'
WALRUS_SHA = hashlib.sha256(requests.get(WALRUS_URL).content).hexdigest()
# print(WALRUS_URL)
# print(WALRUS_SHA)

PARSO = subprocess.check_output(['poet', 'parso']).decode().strip()
TBTRIM = subprocess.check_output(['poet', 'tbtrim']).decode().strip()
# print(PARSO)
# print(TBTRIM)

match = re.match(r'([0-9.]+)\.post([0-9])', VERSION)
if match is None:
    WALRUS = (f'url "{WALRUS_URL}"\n'
              f'  sha256 "{WALRUS_SHA}"')
else:
    version, revision = match.groups()
    WALRUS = (f'url "{WALRUS_URL}"\n'
              f'  version "{version}"\n'
              f'  sha256 "{WALRUS_SHA}"\n'
              f'  revision {revision}')


FORMULA = f'''\
class Walrus < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 assignment expressions"
  homepage "https://github.com/JarryShaw/walrus#walrus"
  {WALRUS}

  head "https://github.com/JarryShaw/walrus.git", :branch => "master"

  depends_on "python"

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
    repo_root = subprocess.check_output(['brew', '--repository', 'jarryshaw/tap'], encoding='utf-8').strip()
    formula = os.path.join(repo_root, 'Formula', 'walrus.rb')
else:
    formula = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                           f'{os.path.splitext(os.path.basename(__file__))[0]}.rb')
with open(formula, 'w') as file:
    file.write(FORMULA)
