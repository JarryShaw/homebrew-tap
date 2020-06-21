class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "https://github.com/netromdk/vermin/archive/v0.10.1.tar.gz"
  sha256 "54a53cd40d6c8cd9be7c8b41952dede0e62a5f69fed71e62efdf5e7ebf84f6f2"
  revision 1

  head "https://github.com/netromdk/vermin.git", :branch => "master"

  depends_on "homebrew/core/python"

  def install
    virtualenv_install_with_resources
  end

  test do
    version = Language::Python.major_minor_version "python3"
    path = libexec/"lib/python#{version}/site-packages/vermin"
    assert_match "Minimum required versions: 2.7, 3.0", shell_output("#{bin}/vermin -q #{path}")
  end
end
