# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/theseal/homebrew-ssh-askpass/master/Formula/ssh-askpass.rb

import os
import plistlib
import re

import requests

url = 'https://raw.githubusercontent.com/theseal/homebrew-ssh-askpass/master/Formula/ssh-askpass.rb'
page = requests.get(url).text

caveats_flag = False
plist_flag = False

caveats_text = list()
plist_text = list()
for line in page.splitlines():
    if 'def caveats; <<~EOF' in line:
        caveats_flag = True
        continue
    if 'def plist; <<~EOS' in line:
        plist_flag = True
        continue

    if caveats_flag:
        if 'EOF' in line:
            caveats_flag = False
            continue
        caveats_text.append(line.strip())

    if plist_flag:
        if 'EOS' in line:
            plist_flag = False
            continue
        plist_text.append(line.strip())

CAVEATS = f'{os.linesep}      '.join(caveats_text).strip()
PLIST = f'{os.linesep}      '.join(plistlib.dumps(plistlib.loads(''.join(plist_text).strip().encode())).decode().strip().splitlines())  # pylint: disable=line-too-long

FORMULA = f'''\
class SshAskpass < Formula
  desc "SSH AskPass util for MacOS"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.2.1.tar.gz"
  sha256 "285e52794db4d1e5d230b115db138cc9b5fcd5e0171c41e3b540e41c540bf357"

  def install
    bin.install "ssh-askpass"
  end

  def caveats
    text = <<~EOF
      {CAVEATS}
    EOF
    text
  end

  plist_options :startup => "true", :manual => "launch ssh-askpass"

  def plist
    file = <<~EOS
      {PLIST}
    EOS
    file
  end

  test do
    system "true"
  end
end
'''

with open('../Formula/ssh-askpass.rb', 'w') as file:
    file.write(FORMULA)
