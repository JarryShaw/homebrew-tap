class Bandit < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://bandit.readthedocs.io/"
  url "https://github.com/PyCQA/bandit/archive/1.7.1.tar.gz"
  sha256 "da93ada8ac8c51288476dd253c9b26a6f9a8a1c9ee1b7d54a2b423d07e9236b5"

  head "https://github.com/PyCQA/bandit.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/34/cc/aaa7a0d066ac9e94fbffa5fcf0738f5742dd7095bdde950bd582fca01f5a/GitPython-3.1.24.tar.gz"
    sha256 "df83fdf5e684fef7c6ee2c02fc68a5ceb7e7e759d08b694088d0cacb4eba59e5"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/36/2b/61d51a2c4f25ef062ae3f74576b01638bebad5e045f747ff12643df63844/PyYAML-6.0.tar.gz"
    sha256 "68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/fc/44/64e02ef96f20b347385f0e9c03098659cb5a1285d36c3d17c56e534d80cf/gitdb-4.0.9.tar.gz"
    sha256 "bac2fd45c0a1c9cf619e63a90d62bdc63892ef92387424b855792a6cabe789aa"
  end

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/f5/0c/3fa7b1f9006e4d454a49b48eac995167cf8617e19375c6963a6b048af0d0/pbr-5.8.0.tar.gz"
    sha256 "672d8ebee84921862110f23fcec2acea191ef58543d34dfe9ef3d9f13c31cddf"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/21/2d/39c6c57032f786f1965022563eec60623bb3e1409ade6ad834ff703724f3/smmap-5.0.0.tar.gz"
    sha256 "c840e62059cd3be204b0c9c9f74be2c09d5648eddd4580d9314c3ecde0b30936"
  end

  resource "stevedore" do
    url "https://files.pythonhosted.org/packages/67/73/cd693fde78c3b2397d49ad2c6cdb082eb0b6a606188876d61f53bae16293/stevedore-3.5.0.tar.gz"
    sha256 "f40253887d8712eaa2bb0ea3830374416736dc8ec0e22f5a65092c1174c44335"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"bandit", "--help"
  end
end
