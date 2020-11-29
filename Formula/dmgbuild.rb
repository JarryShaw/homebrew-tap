class Dmgbuild < Formula
  include Language::Python::Virtualenv

  desc "macOS command-line utility to build disk images"
  homepage "https://github.com/al45tair/dmgbuild"
  url "https://github.com/al45tair/dmgbuild/archive/v1.4.2.tar.gz"
  sha256 "6beb387f706f4f100ae9099440ce57a5dc66d8769da2411266ac5f820bb77031"

  head "https://github.com/al45tair/dmgbuild.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "ds-store" do
    url "https://files.pythonhosted.org/packages/38/a1/cab1b1cf3387eec963a18706854facdc5b699f782985a0001579e5dd6cda/ds_store-1.3.0.tar.gz"
    sha256 "e52478f258626600c1f53fc18c1ddcd8542fa0bca41d4bd81d57c04c87aabf24"
  end

  resource "mac-alias" do
    url "https://files.pythonhosted.org/packages/6c/56/44da6a046876e5fb36e2bf3e5e0a41fc8f4b49ac2d18ca54430cb3688d06/mac_alias-2.1.1.tar.gz"
    sha256 "55468c84a87c8b3929a3dc98f753194f7fe93fd8621abbfea1a4019448058a14"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dmgbuild", "--help"
  end
end
