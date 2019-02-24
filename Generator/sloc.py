# -*- coding: utf-8 -*-

import hashlib
import re
import subprocess
import sys

formula = subprocess.check_output(['brew', 'formula', 'sloc']).decode().strip()

context = list()
with open(formula) as file:
    for line in file:
        context.append(line)
        if 'depends_on "node"' in line:
            context.append('\n')
            context.append('  conflicts_with "sloc", :because => "it is now integrated with homebrew-core"\n')

FORMULA = ''.join(context)

with open('../Formula/sloc.rb', 'w') as file:
    file.write(FORMULA)
