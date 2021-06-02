class Dmgbuild < Formula
  include Language::Python::Virtualenv

  desc "macOS command-line utility to build disk images"
  homepage "https://github.com/al45tair/dmgbuild"
  url "https://github.com/al45tair/dmgbuild/archive/v1.5.2.tar.gz"
  sha256 "e52e9f92c4c1d348f3efcf82ab4d27240030e95e99253e522d8d559127b942ce"

  head "https://github.com/al45tair/dmgbuild.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "ds-store" do
    url "https://files.pythonhosted.org/packages/38/a1/cab1b1cf3387eec963a18706854facdc5b699f782985a0001579e5dd6cda/ds_store-1.3.0.tar.gz"
    sha256 "e52478f258626600c1f53fc18c1ddcd8542fa0bca41d4bd81d57c04c87aabf24"
  end

  resource "mac-alias" do
    url "https://files.pythonhosted.org/packages/54/cf/d4379fc5a6c7835ef92ff8ca49e8dc1c5c51b3c72333a394118887c87a6d/mac_alias-2.2.0.tar.gz"
    sha256 "0eb84a63f98bf54c2f9fbdc4de956a63e64eb8a4a124143a1c1f5a78326442f0"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dmgbuild", "--help"
  end
end
