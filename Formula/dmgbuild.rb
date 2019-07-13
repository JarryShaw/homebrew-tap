class Dmgbuild < Formula
  include Language::Python::Virtualenv

  desc "macOS command-line utility to build disk images"
  homepage "https://github.com/al45tair/dmgbuild"
  url "https://github.com/al45tair/dmgbuild/archive/v1.3.2.tar.gz"
  sha256 "71bf117576dcc054fe6f0f48252cb1f0ccbc9e8ce6b689c064f00d65c32c709d"

  head "https://github.com/al45tair/dmgbuild.git", :branch => "master"

  depends_on "python"

  resource "biplist" do
    url "https://files.pythonhosted.org/packages/3e/56/2db170a498c9c6545cda16e93c2f2ef9302da44802787b45a8a520d01bdb/biplist-1.0.3.tar.gz"
    sha256 "4c0549764c5fe50b28042ec21aa2e14fe1a2224e239a1dae77d9e7f3932aa4c6"
  end

  resource "ds_store" do
    url "https://files.pythonhosted.org/packages/7a/58/e3caf42daddef72a7c92778dba181ff37edd04fb64869eea504ee6b6ea8f/ds_store-1.1.2.tar.gz"
    sha256 "f569659cfd66b21273c5a2405d5e1e0f54fddebf627130329f01404f271a074c"
  end

  resource "mac_alias" do
    url "https://files.pythonhosted.org/packages/42/19/cabae650ad5f97367796495c8748ca748cfde6a05c10ead0382f369075d3/mac_alias-2.0.7.tar.gz"
    sha256 "c485e3eb9d600208cc0aa906282f0d575a535395306289bcdb4096599189e223"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dmgbuild", "--help"
  end
end
