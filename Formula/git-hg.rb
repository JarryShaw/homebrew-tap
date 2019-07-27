class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    :revision => "16b573ed0567e89348ba1d066e6afe5bb48b916c"
  version "2019.7.26"

  depends_on "mercurial"
  depends_on "python@2"

  patch :DATA

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

__END__
diff --git a/bin/git-hg b/bin/git-hg
index be3223c..0259cea 100755
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
