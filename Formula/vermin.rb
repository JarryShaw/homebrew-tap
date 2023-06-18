class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "https://github.com/netromdk/vermin/archive/v1.5.2.tar.gz"
  sha256 "e4b6ca6f3e71b0d83a179dc4a4ba50682f60474cf8c948ba9f82e330f219ff4a"

  head "https://github.com/netromdk/vermin.git", branch: "master"

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
