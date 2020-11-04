# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/sass/homebrew-sass/master/sass.rb

import os

import requests

source = requests.get('https://raw.githubusercontent.com/sass/homebrew-sass/master/sass.rb').text.strip()

context = list()
for line in source.splitlines():
    if line.strip().startswith('class Sass'):
        line = line.replace('Sass', 'DartSass')
    if line.strip().startswith('desc'):
        line = '  desc "Dart implementation of a Sass compiler"'
    if line.strip().startswith('depends_on'):
        context.append('  depends_on "jarryshaw/tap/dart" => :build')
        context.append('')
        context.append('  conflicts_with "homebrew/core/node-sass", because: "both install a `sass` binary"')
        continue
    context.append(line.replace('dart-lang/dart/dart', 'jarryshaw/tap/dart'))
FORMULA = os.linesep.join(context).strip()

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
