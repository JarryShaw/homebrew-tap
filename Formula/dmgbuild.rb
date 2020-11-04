class Dmgbuild < Formula
  include Language::Python::Virtualenv

  desc "macOS command-line utility to build disk images"
  homepage "https://github.com/al45tair/dmgbuild"
  url "https://github.com/al45tair/dmgbuild/archive/v1.4.2.tar.gz"
  sha256 "6beb387f706f4f100ae9099440ce57a5dc66d8769da2411266ac5f820bb77031"

  head "https://github.com/al45tair/dmgbuild.git", :branch => "master"

  depends_on "homebrew/core/python@3.9"

  resource "ds-store" do
    url "https://files.pythonhosted.org/packages/38/a1/cab1b1cf3387eec963a18706854facdc5b699f782985a0001579e5dd6cda/ds_store-1.3.0.tar.gz"
    sha256 "e52478f258626600c1f53fc18c1ddcd8542fa0bca41d4bd81d57c04c87aabf24"
  end

  resource "mac-alias" do
    url "https://files.pythonhosted.org/packages/ac/ff/908032d85725c30883a4ad69dcdee5d12930f951f6af12340075f57c9e6d/mac_alias-2.1.0.tar.gz"
    sha256 "9f07926e9befcc4ab35212d19541fe0e4e4abd67a7641aa75252a3ffd8deae94"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dmgbuild", "--help"
  end
end
