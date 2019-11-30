# -*- coding: utf-8 -*-

import os
import re
import subprocess

context = list()
for line in subprocess.check_output(['noob', 'sass'], encoding='utf-8').splitlines():
    if re.match(r'\s*version ".+?"\s*', line):
        continue
    if line.strip().startswith('class Sass'):
        line = line.replace('Sass', 'NodeSass')
    if line.strip().startswith('desc'):
        line = '  desc "Pure JavaScript implementation of SASS"'
    if line.strip() == 'raise "Test not implemented."':
        line = os.linesep.join([
            '    (testpath/"test.scss").write <<~EOS',
            '      div {',
            '        img {',
            '          border: 0px;',
            '        }',
            '      }',
            '    EOS',
            '',
            '    assert_equal "div img{border:0px}",',
            '    shell_output("#{bin}/sass --style=compressed test.scss").strip',
        ])
    context.append(line)

FORMULA = os.linesep.join(context)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    print(FORMULA, file=file)
