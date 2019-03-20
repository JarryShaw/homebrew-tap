class Pyinstaller < Formula
  include Language::Python::Virtualenv

  desc "Bundle a Python application and all its dependencies"
  homepage "https://www.pyinstaller.org"
  url "https://files.pythonhosted.org/packages/03/32/0e0de593f129bf1d1e77eed562496d154ef4460fd5cecfd78612ef39a0cc/PyInstaller-3.4.tar.gz"
  sha256 "a5a6e04a66abfcf8761e89a2ebad937919c6be33a7b8963e1a961b55cb35986b"

  head "https://github.com/pyinstaller/pyinstaller.git", :branch => "develop"

  bottle :unneeded

  depends_on "python"

  resource "altgraph" do
    url "https://files.pythonhosted.org/packages/da/a4/6c508ac94d7a65859a7a47e6fbde4aa6b81d0f0863aa45861241e782391c/altgraph-0.16.1.tar.gz"
    sha256 "ddf5320017147ba7b810198e0b6619bd7b5563aa034da388cea8546b877f9b0c"
  end

  resource "altgraph" do
    url "https://files.pythonhosted.org/packages/da/a4/6c508ac94d7a65859a7a47e6fbde4aa6b81d0f0863aa45861241e782391c/altgraph-0.16.1.tar.gz"
    sha256 "ddf5320017147ba7b810198e0b6619bd7b5563aa034da388cea8546b877f9b0c"
  end

  resource "macholib" do
    url "https://files.pythonhosted.org/packages/72/60/2b22bef6edfb2864f7c0dc1d55b75e70ba1c3670899bead37e059e29b738/macholib-1.11.tar.gz"
    sha256 "c4180ffc6f909bf8db6cd81cff4b6f601d575568f4d5dee148c830e9851eb9db"
  end

  resource "future" do
    url "https://files.pythonhosted.org/packages/90/52/e20466b85000a181e1e144fd8305caf2cf475e2f9674e797b222f8105f5f/future-0.17.1.tar.gz"
    sha256 "67045236dcfd6816dc439556d009594abf643e5eb48992e36beac09c2ca659b8"
  end

  resource "pefile" do
    url "https://files.pythonhosted.org/packages/ed/cc/157f20038a80b6a9988abc06c11a4959be8305a0d33b6d21a134127092d4/pefile-2018.8.8.tar.gz"
    sha256 "4c5b7e2de0c8cb6c504592167acf83115cbbde01fe4a507c16a1422850e86cd6"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"pyinstaller", "--help"
  end
end
