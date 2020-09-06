# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess  # nosec
import typing

import requests

if typing.TYPE_CHECKING:
    VERSION = ''
for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():  # nosec
    match = re.match(r"vermin==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

VERMIN_URL = f'https://github.com/netromdk/vermin/archive/v{VERSION}.tar.gz'
VERMIN_SHA = hashlib.sha256(requests.get(VERMIN_URL).content).hexdigest()

FORMULA = f'''\
class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "{VERMIN_URL}"
  sha256 "{VERMIN_SHA}"

  head "https://github.com/netromdk/vermin.git", :branch => "master"

  depends_on "homebrew/core/python"

  def install
    virtualenv_install_with_resources
  end

  test do
    version = Language::Python.major_minor_version "python3"
    path = libexec/"lib/python#{{version}}/site-packages/vermin"
    assert_match "Minimum required versions: 2.7, 3.0", shell_output("#{{bin}}/vermin -q #{{path}}")
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
