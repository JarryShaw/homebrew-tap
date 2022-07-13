# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/nlohmann/homebrew-json/master/nlohmann_json.rb

import os
import subprocess  # nosec: B404

formula = subprocess.check_output(['brew', 'formula', 'nlohmann-json']).decode().strip()  # nosec: B603 B607

context = []
with open(formula, encoding='utf-8') as file:
    for line in file:
        context.append(line)
        if 'depends_on "cmake" => :build' in line:
            context.append('\n')
            context.append('  conflicts_with "homebrew/core/nlohmann-json", '
                           'because: "it is now integrated with homebrew-core"\n')

FORMULA = ''.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w', encoding='utf-8') as file:
    file.write(FORMULA)
