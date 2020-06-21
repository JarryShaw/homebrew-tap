# -*- coding: utf-8 -*-

import os
import subprocess

formula = subprocess.check_output(['brew', 'formula', 'pyinstaller']).decode().strip()

context = list()
with open(formula) as file:
    for line in file:
        if 'depends_on "python@3.8"' in line:
            context.append('  depends_on "homebrew/core/python@3.8"\n')
            context.append('\n')
            context.append('  conflicts_with "homebrew/core/pyinstaller", :because => "it is now integrated with homebrew-core"\n')
            continue
        context.append(line)

FORMULA = ''.join(context).strip()

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
