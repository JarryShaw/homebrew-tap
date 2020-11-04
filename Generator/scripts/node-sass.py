# -*- coding: utf-8 -*-

import os
import subprocess  # nosec: B404

formula = subprocess.check_output(['brew', 'formula', 'node-sass']).decode().strip()  # nosec: B603,B607

context = list()
with open(formula) as file:
    for line in file:
        if 'depends_on "node"' in line:
            context.append('  depends_on "homebrew/core/node"\n')
            context.append('\n')
            context.append('  conflicts_with "homebrew/core/node-sass", because: "it is now integrated with homebrew-core"\n')
            context.append('  conflicts_with "jarryshaw/tap/dart-sass", because: "both install a `sass` binary"\n')
            continue
        context.append(line)

FORMULA = ''.join(context).strip()

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
