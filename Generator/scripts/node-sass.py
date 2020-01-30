# -*- coding: utf-8 -*-

import os
import subprocess

formula = subprocess.check_output(['brew', 'formula', 'node-sass']).decode().strip()

context = list()
with open(formula) as file:
    for line in file:
        context.append(line)
        if 'depends_on "node"' in line:
            context.append('\n')
            context.append('  conflicts_with "node-sass", :because => "it is now integrated with homebrew-core"\n')
            context.append('  conflicts_with "jarryshaw/tap/dart-sass", :because => "both install a `sass` binary"')

FORMULA = ''.join(context).strip()

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
