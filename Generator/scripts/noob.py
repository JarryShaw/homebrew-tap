# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/zmwangx/homebrew-npm-noob/master/Formula/noob.rb

import os
import subprocess

formula = subprocess.check_output(['brew', 'formula', 'noob']).decode().strip()

context = list()
with open(formula) as file:
    for line in file:
        context.append(line)
        if 'depends_on "python3"' in line:
            context.append('\n')
            context.append('  conflicts_with "noob", :because => "it is now integrated with homebrew-core"\n')

FORMULA = ''.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
