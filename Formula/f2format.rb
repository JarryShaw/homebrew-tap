class F2format < Formula
  include Language::Python::Virtualenv

  version "0.4.0.post1"
  desc "Back-port compiler for Python 3.6 f-string literals."
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://files.pythonhosted.org/packages/de/5b/4be9f10c0c0683a0e2cc306869d2dc7d7766fc548e27d590cd40a0b81105/f2format-0.4.0.post1.tar.gz"
  sha256 "5b4e760bc6ff08e0843efaafa7ec5ea73fbd76113eb1aef99ffb17c097158485"
  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  bottle :unneeded

  devel do
    url "https://codeload.github.com/JarryShaw/f2format/tar.gz/v0.4.0.post1"
    sha256 "8059ffe2b612b6757f37ecd08e1eb7ec35a236939312e6983189fe3d57be5a14"
  end

  depends_on "python"

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/db/a8/7d6439c1aec525ed70810abee5b7d7f3aa35347f59bc28343e8f62019aa2/pathlib2-2.3.2.tar.gz"
    sha256 "8eb170f8d0d61825e09a95b38be068299ddeda82f35e96c3301a8a5e7604cb83"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "typed-ast" do
    url "https://files.pythonhosted.org/packages/52/cf/2ebc7d282f026e21eed4987e42e10964a077c13cfc168b42f3573a7f178c/typed-ast-1.1.0.tar.gz"
    sha256 "57fe287f0cdd9ceaf69e7b71a2e94a24b5d268b35df251a88fef5cc241bf73aa"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"f2format", "--help"
  end
end
