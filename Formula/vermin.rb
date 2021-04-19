class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "https://github.com/netromdk/vermin/archive/v1.1.1.tar.gz"
  sha256 "d13b2281ba16c9d5b0913646483771789552230a9ed625e2cd92c5a112e4ae80"

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
