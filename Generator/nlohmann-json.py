# -*- coding: utf-8 -*-
# originally from https://raw.githubusercontent.com/nlohmann/homebrew-json/master/nlohmann_json.rb

import subprocess

formula = subprocess.check_output(['brew', 'formula', 'nlohmann-json']).decode().strip()

context = list()
with open(formula) as file:
    for line in file:
        context.append(line)
        if 'depends_on "cmake" => :build' in line:
            context.append('\n')
            context.append('  conflicts_with "nlohmann-json", :because => "it is now integrated with homebrew-core"\n')

FORMULA = ''.join(context)

with open('../Formula/nlohmann-json.rb', 'w') as file:
    file.write(FORMULA)
