class Macdaily < Formula
  include Language::Python::Virtualenv

  version "0.2.3"
  desc "Back-port compiler for Python 3.6 f-string literals."
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://files.pythonhosted.org/packages/e7/df/82f0dd6fd59d115bd432875c6041c3b9c42ab412b51d95247698412bbd19/f2format-0.2.3.tar.gz"
  sha256 "ea1515be17572a831db6fa1b999533340988504a36c0f36b1f0b4bdc2e167fe0"
  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  bottle :unneeded

  devel do
    url "https://codeload.github.com/JarryShaw/f2format/tar.gz/v0.2.3"
    sha256 "395408a3dc9c3db2b5c200b8722a13a60898c861633b99e6e250186adffd1370"
  end

  depends_on "python"

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/db/a8/7d6439c1aec525ed70810abee5b7d7f3aa35347f59bc28343e8f62019aa2/pathlib2-2.3.2.tar.gz"
    sha256 "8eb170f8d0d61825e09a95b38be068299ddeda82f35e96c3301a8a5e7604cb83"
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
