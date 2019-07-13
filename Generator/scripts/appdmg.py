# -*- coding: utf-8 -*-

import os
import re
import subprocess

context = list()
for line in subprocess.check_output(['noob', 'appdmg'], encoding='utf-8').splitlines():
    if re.match(r'\s*version ".+?"\s*', line):
        continue
    if line.strip() == 'raise "Test not implemented."':
        line = '    system bin/"appdmg", "--help"'
    context.append(line)

FORMULA = os.linesep.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
