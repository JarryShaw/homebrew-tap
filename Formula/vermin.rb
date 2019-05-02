class Vermin < Formula
  include Language::Python::Virtualenv

  desc "Concurrently detect the minimum Python versions needed to run code"
  homepage "https://github.com/netromdk/vermin"
  url "https://github.com/netromdk/vermin/archive/v0.4.11.tar.gz"
  sha256 "48e9083408ecd2006b26923c023249f4446371fe75ae462d3499d64ccd107f88"

  head "https://github.com/netromdk/vermin.git", :branch => "master"

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    path = Pathname.glob(libexec/"lib/python?.?/site-packages/vermin")[0]
    assert_match "Minimum required versions: 2.7, 3.0", shell_output("#{bin}/vermin -q #{path}")
  end
end
