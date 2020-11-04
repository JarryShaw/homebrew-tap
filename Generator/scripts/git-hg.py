# -*- coding: utf-8 -*-

import hashlib
import os
import subprocess  # nosec: B404
import time

import pkg_resources

VERSION = pkg_resources.parse_version(time.strftime('%Y.%m.%d'))
REVISION = subprocess.check_output(['git', 'rev-parse', 'HEAD'], encoding='utf-8',  # nosec: B603,B607
                                   cwd='../Submodules/cosmin-git-hg').strip()

PATCH = '''\
--- a/bin/git-hg
+++ b/bin/git-hg
@@ -1,9 +1,9 @@
 #!/bin/sh

-if which python2 >/dev/null 2>&1; then
-    PYTHON=python2
-    export PYTHON
-fi
+PYTHONPATH="$(brew --prefix mercurial)/lib/python2.7/site-packages"
+export PYTHONPATH
+PYTHON="$(brew --prefix python@2)/bin/python"
+export PYTHON

 set -e
'''

PATCH_SHA = hashlib.sha256(PATCH.encode()).hexdigest()

FORMULA = f'''\
class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    revision: "{REVISION}"
  version "{VERSION}"

  depends_on "homebrew/core/mercurial"
  depends_on "homebrew/core/python@2"

  # patch :DATA
  patch do
    url "https://github.com/JarryShaw/homebrew-tap/raw/76dd3cc274fed8fc71b844514f482b6d5d7eca16/Patches/git-hg.patch"
    sha256 "{PATCH_SHA}"
  end

  def install
    # install git-hg
    bin.install "bin/git-hg"

    inreplace "fast-export/hg-fast-export.sh", "ROOT=\\"`dirname $0`\\"", "ROOT=\\"#{{lib}}\\""

    # install hg-fast-export.(sh|py)
    lib.install "fast-export/hg-fast-export.sh"
    lib.install "fast-export/hg-fast-export.py"
    lib.install "fast-export/hg2git.py"

    # make alias
    bin.install_symlink lib/"hg-fast-export.sh" => "hg-fast-export"
  end

  test do
    system bin/"git-hg", "help"
  end
end
'''

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Formula',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.rb'), 'w') as file:
    file.write(FORMULA)

with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', 'Patches',
                       f'{os.path.splitext(os.path.basename(__file__))[0]}.patch'), 'w') as file:
    file.write(PATCH)
