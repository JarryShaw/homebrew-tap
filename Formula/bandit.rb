class Bandit < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://bandit.readthedocs.io/"
  url "https://github.com/PyCQA/bandit/archive/1.6.2.tar.gz"
  sha256 "5be37593959fc90d4c6f9992486ca94ceead919adb3cf8e3cdf8b1aa44cbfc00"

  head "https://github.com/PyCQA/bandit.git", :branch => "master"

  depends_on "homebrew/core/python@3.9"

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/53/ea/fc34cddaa30bfc5e283f13e754fb3e2648ccd9f7019eaa3518fb5350ae51/GitPython-3.1.7.tar.gz"
    sha256 "2db287d71a284e22e5c2846042d0602465c7434d910406990d5b74df4afb0858"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz"
    sha256 "b8eac752c5e14d3eca0e6dd9199cd627518cb5ec06add0de9d32baeee6fe645d"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/d1/05/eaf2ac564344030d8b3ce870b116d7bb559020163e80d9aa4a3d75f3e820/gitdb-4.0.5.tar.gz"
    sha256 "c9e1f2d0db7ddb9a704c2a0217be31214e91a4fe1dea1efad19ae42ba0c285c9"
  end

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/8a/a8/bb34d7997eb360bc3e98d201a20b5ef44e54098bb2b8e978ae620d933002/pbr-5.4.5.tar.gz"
    sha256 "07f558fece33b05caf857474a366dfcc00562bca13dd8b47b2b3e22d9f9bf55c"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/75/fb/2f594e5364f9c986b2c89eb662fc6067292cb3df2b88ae31c939b9138bb9/smmap-3.0.4.tar.gz"
    sha256 "9c98bbd1f9786d22f14b3d4126894d56befb835ec90cef151af566c7e19b5d24"
  end

  resource "stevedore" do
    url "https://files.pythonhosted.org/packages/bc/3e/0f33515b3b1638e839219f14c09b9b75f86f630c47ad9e79137f73e99a97/stevedore-3.2.0.tar.gz"
    sha256 "38791aa5bed922b0a844513c5f9ed37774b68edc609e5ab8ab8d8fe0ce4315e5"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"bandit", "--help"
  end
end
