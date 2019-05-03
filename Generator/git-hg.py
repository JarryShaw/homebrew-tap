# -*- coding: utf-8 -*-

import subprocess
import time

VERSION = time.strftime('%Y.%m.%d')
REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], encoding='utf-8',
                                   cwd='../Submodules/cosmin-git-hg').strip()

FORMULA = f'''\
class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    :revision => "{REVISION}"
  version "{VERSION}"

  depends_on "mercurial"

  def install
    bin.install "bin/git-hg"

    # install hg-fast-export.(sh|py)
    bin.install "fast-export/hg-fast-export.sh"
    bin.install "fast-export/hg-fast-export.py"
    bin.install "fast-export/hg2git.py"

    # make alias
    ln_s bin/"hg-fast-export.sh", bin/"hg-fast-export"
  end

  test do
    system bin/"git-hg", "help"
  end
end
'''

with open('../Formula/git-hg.rb', 'w') as file:
    file.write(FORMULA)
