class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "https://github.com/netromdk/vermin/archive/v1.0.1.tar.gz"
  sha256 "c06183ba653b9d5f6687a6686da8565fb127fab035f9127a5acb172b7c445079"

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
