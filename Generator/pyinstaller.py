# -*- coding: utf-8 -*-

import subprocess

formula = subprocess.check_output(['brew', 'formula', 'pyinstaller']).decode().strip()

context = list()
with open(formula) as file:
    for line in file:
        context.append(line)
        if 'depends_on "cmake" => :build' in line:
            context.append('\n')
            context.append('  conflicts_with "pyinstaller", :because => "it is now integrated with homebrew-core"\n')

FORMULA = ''.join(context)

with open('../Formula/pyinstaller.rb', 'w') as file:
    file.write(FORMULA)
