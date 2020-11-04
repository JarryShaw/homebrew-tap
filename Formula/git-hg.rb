class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    :revision => "e29d4c07e680a86b892ff4567c97ac2613dc6343"
  version "2020.11.4"

  depends_on "homebrew/core/mercurial"
  depends_on "homebrew/core/python@2"
w
  # patch :DATA
  patch do
    url "https://raw.githubusercontent.com/JarryShaw/homebrew-tap/master/Patches/git-hg.patch"
    sha256 "fdc08b396ffb9e01402bf0b2bde759735f9724dd3c26dda9d65e384a83efc80e"
  end

  def install
    # install git-hg
    bin.install "bin/git-hg"

    inreplace "fast-export/hg-fast-export.sh", "ROOT=\"`dirname $0`\"", "ROOT=\"#{lib}\""

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

# __END__
# diff --git a/bin/git-hg b/bin/git-hg
# index be3223c..0259cea 100755
# --- a/bin/git-hg
# +++ b/bin/git-hg
# @@ -1,9 +1,9 @@
#  #!/bin/sh

# -if which python2 >/dev/null 2>&1; then
# -    PYTHON=python2
# -    export PYTHON
# -fi
# +PYTHONPATH="$(brew --prefix mercurial)/lib/python2.7/site-packages"
# +export PYTHONPATH
# +PYTHON="$(brew --prefix python@2)/bin/python"
# +export PYTHON

#  set -e
