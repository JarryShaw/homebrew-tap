# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess

import requests

with open(os.path.expanduser('~/GitHub/poseur/poseur.py'), 'r') as file:
    for line in file:
        match = re.match(r"^__version__ = '(.*)'", line)
        if match is None:
            continue
        VERSION = match.groups()[0]
        break
# print(VERSION)

POSEUR_URL = f'https://github.com/JarryShaw/poseur/archive/v{VERSION}.tar.gz'
POSEUR_SHA = hashlib.sha256(requests.get(POSEUR_URL).content).hexdigest()
# print(POSEUR_URL)
# print(POSEUR_SHA)

PARSO = subprocess.check_output(['poet', 'parso']).decode().strip()
TBTRIM = subprocess.check_output(['poet', 'tbtrim']).decode().strip()
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
  homepage "https://github.com/JarryShaw/poseur#poseur"
  {POSEUR}

  head "https://github.com/JarryShaw/poseur.git", :branch => "master"

  depends_on "python"

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
          - str, name of positional-only arguments

          Refs:
          - https://mail.python.org/pipermail/python-ideas/2017-February/044888.html

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
    repo_root = subprocess.check_output(['brew', '--repository', 'jarryshaw/tap'], encoding='utf-8').strip()
    formula = os.path.join(repo_root, 'Formula', 'poseur.rb')
else:
    formula = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                           f'{os.path.splitext(os.path.basename(__file__))[0]}.rb')
with open(formula, 'w') as file:
    file.write(FORMULA)
