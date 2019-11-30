# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess

import requests

with open(os.path.expanduser('~/GitHub/f2format/f2format.py'), 'r') as file:
    for line in file:
        match = re.match(r"^__version__ = '(.*)'", line)
        if match is None:
            continue
        VERSION = match.groups()[0]
        break
# print(VERSION)

F2FORMAT_URL = f'https://github.com/JarryShaw/f2format/archive/v{VERSION}.tar.gz'
F2FORMAT_SHA = hashlib.sha256(requests.get(F2FORMAT_URL).content).hexdigest()
# print(F2FORMAT_URL)
# print(F2FORMAT_SHA)

PARSO = subprocess.check_output(['poet', 'parso']).decode().strip()
TBTRIM = subprocess.check_output(['poet', 'tbtrim']).decode().strip()
# print(PARSO)
# print(TBTRIM)

match = re.match(r'([0-9.]+)\.post([0-9]+)', VERSION)
if match is None:
    F2FORMAT = (f'url "{F2FORMAT_URL}"\n'
                f'  sha256 "{F2FORMAT_SHA}"')
else:
    version, subversion = match.groups()
    revision = chr(96 + int(subversion))  # ord('a') -> 97
    F2FORMAT = (f'url "{F2FORMAT_URL}"\n'
                f'  version "{version}{revision}"\n'
                f'  sha256 "{F2FORMAT_SHA}"')


FORMULA = f'''\
class F2format < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.6 f-string literals"
  homepage "https://github.com/JarryShaw/f2format#f2format"
  {F2FORMAT}

  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  depends_on "python"

  {PARSO}

  {TBTRIM}

  def install
    virtualenv_install_with_resources
    man1.install "share/f2format.1"
    bash_completion.install "share/f2format.bash-completion"
  end

  test do
    (testpath/"test.py").write <<~EOS
      var = f'foo{{(1+2)*3:>5}}bar{{"a", "b"!r}}boo'
    EOS

    std_output = <<~EOS
      var = 'foo{{:>5}}bar{{!r}}boo'.format((1+2)*3, ("a", "b"))
    EOS

    system bin/"f2format", "--no-archive", "test.py"
    assert_match std_output, shell_output("cat test.py")
  end
end
'''

if os.path.basename(__file__) == 'setup-formula.py':
    repo_root = subprocess.check_output(['brew', '--repository', 'jarryshaw/tap'], encoding='utf-8').strip()
    formula = os.path.join(repo_root, 'Formula', 'f2format.rb')
else:
    formula = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                           f'{os.path.splitext(os.path.basename(__file__))[0]}.rb')
with open(formula, 'w') as file:
    file.write(FORMULA)
