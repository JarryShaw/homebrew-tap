class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    :revision => "16b573ed0567e89348ba1d066e6afe5bb48b916c"
  version "2019.5.3"

  depends_on "mercurial"
  depends_on "python"

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
