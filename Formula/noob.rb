class Noob < Formula
  include Language::Python::Virtualenv

  desc "Generate Homebrew formulae for npm packages"
  homepage "https://github.com/zmwangx/homebrew-npm-noob"
  url "https://github.com/zmwangx/homebrew-npm-noob/archive/v0.3.tar.gz"
  sha256 "fc1833d2a12b3737d19c0bb9cfa46937c5a5d903b232fb01baa57e97c8ebbab5"

  head "https://github.com/zmwangx/homebrew-npm-noob.git", branch: "master"

  depends_on "homebrew/core/python"

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/87/5b/aae44c6655f3801e81aa3eef09dbbf012431987ba564d7231722f68df02d/MarkupSafe-2.1.5.tar.gz"
    sha256 "d283d37a890ba4c1ae73ffadf8046435c76e7bc2247bbb63c00bd1a709c6544b"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/71/da/e94e26401b62acd6d91df2b52954aceb7f561743aa5ccc32152886c76c96/certifi-2024.2.2.tar.gz"
    sha256 "0569859f95fc761b18b45ef421b1290a0f65f147e92a1e5eb3e635f9a5e4e66f"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/bf/3f/ea4b9117521a1e9c50344b909be7886dd00a519552724809bb1f486986c2/idna-3.6.tar.gz"
    sha256 "9ecdbbd083b06798ae1e86adcbfe8ab1479cf864e4ee30fe4e46a003d12491ca"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/b2/5e/3a21abf3cd467d7876045335e681d276ac32492febe6d98ad89562d1a7e1/Jinja2-3.1.3.tar.gz"
    sha256 "ac8bd6544d4bb2c9792bf3a159e80bba8fda7f07e81bc3aed565432d5925ba90"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e2/cc/abf6746cc90bc52df4ba730f301b89b3b844d6dc133cb89a01cfe2511eb9/urllib3-2.2.0.tar.gz"
    sha256 "051d961ad0c62a94e50ecf1af379c3aba230c66c710493493560c0c223c49f20"
  end

  def install
    virtualenv_install_with_resources
    man1.install "docs/noob.1"
  end

  test do
    assert_match "class Svgo < Formula", shell_output("#{bin}/noob svgo")
  end
end
