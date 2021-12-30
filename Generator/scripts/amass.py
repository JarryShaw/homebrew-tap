# -*- coding: utf-8 -*-
# originally from hhttps://raw.githubusercontent.com/caffix/homebrew-amass/master/formula/amass.rb

import os

import requests

source = requests.get('https://raw.githubusercontent.com/caffix/homebrew-amass/master/formula/amass.rb').text.strip()

context = list()
for line in source.splitlines():
    if line.strip().startswith('desc'):
        line = '  desc "In-depth attack surface mapping and asset discovery"'
    if line.strip().startswith('version'):
        continue
    context.append(line)
FORMULA = os.linesep.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
