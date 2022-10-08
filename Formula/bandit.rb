class Bandit < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://bandit.readthedocs.io/"
  url "https://github.com/PyCQA/bandit/archive/1.7.4.tar.gz"
  sha256 "232169b0ad84059f9013346c519406b68c969d9ed580f231781ac6ca947218a0"

  head "https://github.com/PyCQA/bandit.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/1e/2d/6ccc5a2a05a474e7ae7ef7b1372ead9381378c438da4cc3434109b376d82/GitPython-3.1.28.tar.gz"
    sha256 "6bd3451b8271132f099ceeaf581392eaf6c274af74bb06144307870479d0697c"
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
    url "https://files.pythonhosted.org/packages/b4/40/4c5d3681b141a10c24c890c28345fac915dd67f34b8c910df7b81ac5c7b3/pbr-5.10.0.tar.gz"
    sha256 "cfcc4ff8e698256fc17ea3ff796478b050852585aa5bae79ecd05b2ab7b39b9a"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/21/2d/39c6c57032f786f1965022563eec60623bb3e1409ade6ad834ff703724f3/smmap-5.0.0.tar.gz"
    sha256 "c840e62059cd3be204b0c9c9f74be2c09d5648eddd4580d9314c3ecde0b30936"
  end

  resource "stevedore" do
    url "https://files.pythonhosted.org/packages/f5/70/7953626fd19faa7a0852779c1949650e825f650ee6060f68658a84584c26/stevedore-4.0.0.tar.gz"
    sha256 "f82cc99a1ff552310d19c379827c2c64dd9f85a38bcd5559db2470161867b786"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"bandit", "--help"
  end
end
