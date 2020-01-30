# -*- coding: utf-8 -*-

import hashlib
import os
import re
import subprocess

import requests

for line in subprocess.check_output(['pip', 'freeze']).decode().splitlines():
    match = re.match(r"docutils==(.*)", line, re.IGNORECASE)
    if match is not None:
        VERSION = match.groups()[0]

DOCUTILS_URL = f'https://downloads.sourceforge.net/project/docutils/docutils/{VERSION}/docutils-{VERSION}.tar.gz'
DOCUTILS_SHA = hashlib.sha256(requests.get(DOCUTILS_URL).content).hexdigest()

install_raqm_cmake = requests.get('https://github.com/python-pillow/Pillow/raw/master/depends/install_raqm_cmake.sh')
for line in install_raqm_cmake.text.splitlines():
    match = re.match(r"archive=(.*)", line, re.IGNORECASE)
    if match is not None:
        ARCHIVE = match.groups()[0]

RAQM_URL = f'https://raw.githubusercontent.com/python-pillow/pillow-depends/master/{ARCHIVE}.tar.gz'
RAQM_SHA = hashlib.sha256(requests.get(RAQM_URL).content).hexdigest()

PILLOW = subprocess.check_output(['poet', 'Pillow']).decode().strip()
PYGMENTS = subprocess.check_output(['poet', 'Pygments']).decode().strip()

FORMULA = f'''\
class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "{DOCUTILS_URL}"
  sha256 "{DOCUTILS_SHA}"

  option "without-pil", "build without Python Image Library support"
  option "without-pygments", "build without code syntax highlighting support"

  depends_on "python"
  depends_on "freetype" => :build
  depends_on "fribidi" => :build
  depends_on "harfbuzz" => :build
  depends_on "libjpeg" => :build
  depends_on "libtiff" => :build
  depends_on "little-cms2" => :build
  depends_on "webp" => :build

  conflicts_with "docutils", :because => "this is a port of docutils from homebrew-core"

  resource "libraqm" do
    url "{RAQM_URL}"
    sha256 "{RAQM_SHA}"
  end

  {PILLOW}

  {PYGMENTS}

  def install
    # create virtualenv
    venv = virtualenv_create(libexec)

    # install Pygments
    if build.with?("pygments")
      venv.pip_install resource("Pygments")
    end

    # install PIL
    if build.with?("pil")
      resource("libraqm").stage do
        # c.f. https://github.com/python-pillow/Pillow/blob/master/depends/install_raqm_cmake.sh
        (buildpath/"install_raqm_cmake.sh").atomic_write <<~EOS
          pushd $archive

          mkdir build
          cd build
          cmake ..
          make && sudo make install
          cd ..

          popd
        EOS

        system buildpath/"install_raqm_cmake.sh"
      end

      venv.pip_install resource("Pillow")
    end

    # link files
    venv.pip_install_and_link buildpath
  end

  test do
    system "#{{bin}}/rst2man.py", "#{{prefix}}/HISTORY.txt"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
