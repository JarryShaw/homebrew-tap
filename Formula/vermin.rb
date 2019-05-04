class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "https://github.com/netromdk/vermin/archive/v0.5.0.tar.gz"
  sha256 "a5546006c77bc487da10b7cdbb3c5196e8afe07415181ac4a1cb175d7cd3316b"

  head "https://github.com/netromdk/vermin.git", :branch => "master"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    version = Language::Python.major_minor_version "python3"
    path = libexec/"lib/python#{version}/site-packages/vermin"
    assert_match "Minimum required versions: 2.7, 3.0", shell_output("#{bin}/vermin -q #{path}")
  end
end
