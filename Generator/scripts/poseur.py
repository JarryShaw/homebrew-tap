# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess  # nosec: B404
from typing import TYPE_CHECKING

import requests

# with open(os.path.expanduser('~/GitHub/poseur/poseur.py'), 'r') as file:
#     for line in file:
#         match = re.match(r"^__version__ = '(.*)'", line)
#         if match is None:
#             continue
#         VERSION = match.groups()[0]
#         break
# # print(VERSION)
if TYPE_CHECKING:
    VERSION: str

subprocess.check_call(['pip', 'install', 'poseur'])  # nosec: B603 B607

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec: B603 B607
    match = re.match(r"poseur==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

POSEUR_URL = f'https://github.com/pybpc/poseur/archive/v{VERSION}.tar.gz'
POSEUR_SHA = hashlib.sha256(requests.get(POSEUR_URL).content).hexdigest()
# print(POSEUR_URL)
# print(POSEUR_SHA)

PARSO = subprocess.check_output(['poet', 'parso']).decode().strip()  # nosec: B603 B607
TBTRIM = subprocess.check_output(['poet', 'tbtrim']).decode().strip()  # nosec: B603 B607
BPC_UTILS = subprocess.check_output(['poet', 'bpc-utils']).decode().strip()  # nosec: B603 B607
# print(PARSO)
# print(TBTRIM)

match = re.match(r'([0-9.]+)\.post([0-9])', VERSION)
if match is None:
    POSEUR = (f'url "{POSEUR_URL}"\n'
              f'  sha256 "{POSEUR_SHA}"')
else:
    version, subversion = match.groups()
    revision = chr(96 + int(subversion))  # ord('a') -> 97
    POSEUR = (f'url "{POSEUR_URL}"\n'
              f'  version "{version}{revision}"\n'
              f'  sha256 "{POSEUR_SHA}"')

FORMULA = f'''\
class Poseur < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 positional-only parameters syntax"
  homepage "https://github.com/pybpc/poseur#poseur"
  {POSEUR}

  head "https://github.com/pybpc/poseur.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  {BPC_UTILS}

  {PARSO}

  {TBTRIM}

  def install
    rm "setup.py"
    cp "scripts/setup.pypi.py", "setup.py"
    virtualenv_install_with_resources

    man1.install "share/poseur.1"
    bash_completion.install "share/poseur.bash-completion"
  end

  test do
    (testpath/"test.py").write <<~EOS
      def func_g(p_a, p_b=lambda p_a=1, /: p_a):
          pass
    EOS

    std_output = <<~EOS
      def _poseur_decorator(*poseur):
          """Positional-only arguments runtime checker.

          Args:
              *poseur (List[str]): Name of positional-only arguments.

          See Also:
              https://mail.python.org/pipermail/python-ideas/2017-February/044888.html

          """
          import functools
          def caller(func):
              @functools.wraps(func)
              def wrapper(*args, **kwargs):
                  for poseur_args in poseur:
                      if poseur_args in kwargs:
                          raise TypeError('%s() got an unexpected keyword argument %r' % (func.__name__, poseur_args))
                  return func(*args, **kwargs)
              return wrapper
          return caller


      def func_g(p_a, p_b=_poseur_decorator('p_a')(lambda p_a=1: p_a)):
          pass
    EOS

    system bin/"poseur", "--no-archive", "test.py"
    assert_match std_output, shell_output("cat test.py")
  end
end
'''

if os.path.basename(__file__) == 'setup-formula.py':
    repo_root = subprocess.check_output(['brew', '--repository', 'jarryshaw/tap'],   # nosec: B603 B607
                                        encoding='utf-8').strip()
    formula = os.path.join(repo_root, 'Formula', 'poseur.rb')
else:
    formula = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                           f'{os.path.splitext(os.path.basename(__file__))[0]}.rb')
with open(formula, 'w', encoding='utf-8') as file:
    file.write(FORMULA)

subprocess.check_call(['pip-autoremove', '-y', 'poseur'])  # nosec: B603 B607
