# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/alexaubry/homebrew-formulas/master/Formula/uti.rb

import os
import re

import requests

TAG_REGEX = re.compile(r'\s*:tag\s*=>\s*"(?P<tag>.*?)",\s*', re.IGNORECASE)
REVISION_REGEX = re.compile(r'\s*:revision\s*=>\s*"(?P<revision>.*?)",\s*', re.IGNORECASE)

url = 'https://raw.githubusercontent.com/alexaubry/homebrew-formulas/master/Formula/uti.rb'
page = requests.get(url).text
for line in page.splitlines():
    tag_match = TAG_REGEX.match(line)
    if tag_match is not None:
        TAG = tag_match.group('tag')
        continue
    revision_match = REVISION_REGEX.match(line)
    if revision_match is not None:
        REVISION = revision_match.group('revision')
        break

FORMULA = f'''\
class Uti < Formula
  desc "CLI tool for interacting with File Type Identifiers on Mac"
  homepage "https://github.com/alexaubry/uti"
  url "https://github.com/alexaubry/uti.git",
    :tag      => "{TAG}",
    :revision => "{REVISION}",
    :shallow  => false

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox", "--static-swift-stdlib"
    bin.install ".build/release/uti"
  end

  test do
    system "swift", "test"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
