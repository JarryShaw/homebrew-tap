# -*- coding: utf-8 -*-

import os

import requests

FORMULA = requests.get('https://raw.githubusercontent.com/sass/homebrew-sass/master/sass.rb').text.strip()

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
