# -*- coding: utf-8 -*-

import os
import subprocess  # nosec: B404
import time

import pkg_resources

VERSION = pkg_resources.parse_version(time.strftime('%Y.%m.%d'))
REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], encoding='utf-8',  # nosec: B603 B607
                                   cwd='../Submodules/basherpm-basher').strip()

FORMULA = f'''\
class Basher < Formula
  desc "Package manager for shell scripts"
  homepage "https://github.com/basherpm/basher"
  url "https://github.com/basherpm/basher.git",
    revision: "{REVISION}"
  version "{VERSION}"

  depends_on "homebrew/core/bash"
  depends_on "homebrew/core/coreutils"

  def install
    ENV["BASHER_ROOT"] = "#{{prefix}}"

    inreplace libexec/"basher", "$HOME/.basher", "#{{prefix}}"
    inreplace libexec/"basher", "$BASHER_ROOT/cellar", "#{{HOMEBREW_PREFIX}}/lib/basher/cellar"

    Dir["*"].each do |f|
      cp_r f, prefix/f.to_s
    end

    (bash_completion/"basher").write `#{{bin}}/basher init - bash`
    (fish_completion/"basher").write `#{{bin}}/basher init - fish|psub`
    (zsh_completion/"basher").write `#{{bin}}/basher init - zsh`
  end

  def caveats
    <<~EOS
      To make basher work smoothly, link it to your home directory
        ln -s #{{opt_prefix}} ~/.basher

      Or add the following environment variable as
        BASHER_ROOT=#{{opt_prefix}}
    EOS
  end

  test do
    system bin/"basher", "commands"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w', encoding='utf-8') as file:
    file.write(FORMULA)
