class GitHg < Formula
  desc "Checking out and tracking a mercurial repo from git"
  homepage "https://github.com/cosmin/git-hg"
  url "https://github.com/cosmin/git-hg.git",
    :revision => "16b573ed0567e89348ba1d066e6afe5bb48b916c"

  depends_on "mercurial"
  depends_on "python"

  def install
    bin.install "bin/git-hg"
  end

  test do
    system bin/"git-hg", "help"
  end
end
