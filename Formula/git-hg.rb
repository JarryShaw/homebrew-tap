class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    revision: "aff90c3e4fa28f685b9feb9015a1f459b842d54a"
  version "2021.5.20"

  depends_on "homebrew/core/mercurial"
  depends_on "homebrew/core/python@2"

  # patch :DATA
  patch do
    url "https://github.com/JarryShaw/homebrew-tap/raw/76dd3cc274fed8fc71b844514f482b6d5d7eca16/Patches/git-hg.patch"
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
