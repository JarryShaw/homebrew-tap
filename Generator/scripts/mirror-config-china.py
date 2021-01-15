# -*- coding: utf-8 -*-

import os
import re
import subprocess  # nosec: B404

context = list()
for line in subprocess.check_output(['noob', 'mirror-config-china'], encoding='utf-8').splitlines():  # nosec: B603,B607
    if re.match(r'\s*version ".+?"\s*', line):
        continue
    if line.strip() == 'raise "Test not implemented."':
        line = '    system bin/"mirror-config-china", "--registry=https://registry.npm.taobao.org"'
    context.append(line)

FORMULA = os.linesep.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
