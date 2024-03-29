# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/dart-lang/homebrew-dart/master/Formula/dart-beta.rb

import os

import requests

source = requests.get('https://raw.githubusercontent.com/dart-lang/homebrew-dart/master/Formula/dart-beta.rb').text.strip()

context = []
for line in source.splitlines():
    if line.strip().startswith('desc'):
        line = '  desc "SDK for dart language"'
    context.append(line)
FORMULA = os.linesep.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w', encoding='utf-8') as file:
    print(FORMULA, file=file)
