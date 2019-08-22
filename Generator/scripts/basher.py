# -*- coding: utf-8 -*-

import os
import subprocess
import time

import pkg_resources

VERSION = pkg_resources.parse_version(time.strftime('%Y.%m.%d'))
REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], encoding='utf-8',
                                   cwd='../Submodules/basherpm-basher').strip()

FORMULA = f'''\
class Basher < Formula
  desc "Package manager for shell scripts"
  homepage "https://github.com/basherpm/basher"
  url "https://github.com/basherpm/basher.git",
    :revision => "{REVISION}"
  version "{VERSION}"

  def install
    Dir["*"].each do |f|
      cp_r f, prefix/"#{{f}}"
    end

    # Dir[".*"].each do |f|
    #   cp_r f, prefix/"#{{f}}"
    # end

    bash_completion.install "completions/basher.bash"
    zsh_completion.install "completions/basher.zsh"
  end

  def caveats
    text = <<~EOS
      To make basher work smoothly, link it to your home directory
        ln -s /usr/local/opt/basher ~/.basher

      Add `basher init` to your shell to enable basher runtime functions
        echo 'eval "$(basher init -)"' >> ~/.bash_profile

      For Fish, use the following line on your ~/.config/fish/config.fish.
        status --is-interactive; and . (basher init -|psub)
    EOS
    text
  end

  test do
    system bin/"basher", "commands"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)
