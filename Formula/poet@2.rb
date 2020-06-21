class PoetAT2 < Formula
  include Language::Python::Virtualenv

  desc "Generates Homebrew resource stanzas for Python packages"
  homepage "https://github.com/tdsmith/homebrew-pypi-poet"
  url "https://files.pythonhosted.org/packages/f7/d9/4b525af3be6ac0a0a962e101b7771db6511d9e96369ded2765406233f9ff/homebrew-pypi-poet-0.10.0.tar.gz"
  sha256 "e09e997e35a98f66445f9a39ccb33d6d93c5cd090302a59f231707eac0bf378e"

  head "https://github.com/tdsmith/homebrew-pypi-poet.git", :branch => "master"

  keg_only :versioned_formula

  depends_on "homebrew/core/python@2"

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"
    sha256 "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/ac/7e/1b4c2e05809a4414ebce0892fe1e32c14ace86ca7d50c70f00979ca9b3a3/MarkupSafe-1.1.0.tar.gz"
    sha256 "4e97332c9ce444b0c2c38dd22ddc61c743eb208d916e4265a2a3b575bdccb1d3"
  end

  def install
    virtualenv_install_with_resources

    # expose pip for poet
    cp libexec/"bin/pip", libexec/"bin/poet_pip"
    bin.install libexec/"bin/poet_pip"
  end

  test do
    system bin/"poet", "--help"
    system bin/"poet_pip", "--help"
  end
end
