class Dmgbuild < Formula
  include Language::Python::Virtualenv

  desc "macOS command-line utility to build disk images"
  homepage "https://github.com/al45tair/dmgbuild"
  url "https://github.com/al45tair/dmgbuild/archive/v1.6.5.tar.gz"
  sha256 "3590bcb90a75c32ba8b10d692d26838caedbc267a57db23931694abc9598c873"

  head "https://github.com/al45tair/dmgbuild.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "ds-store" do
    url "https://files.pythonhosted.org/packages/7c/36/902259bf7ddb142dd91cf7a9794aa15e1a8ab985974f90375e5d3463b441/ds_store-1.3.1.tar.gz"
    sha256 "c27d413caf13c19acb85d75da4752673f1f38267f9eb6ba81b3b5aa99c2d207c"
  end

  resource "mac-alias" do
    url "https://files.pythonhosted.org/packages/ea/a3/83b50f620d318a98363dc7e701fb94856eaaecc472e23a89ac625697b3ea/mac_alias-2.2.2.tar.gz"
    sha256 "c99c728eb512e955c11f1a6203a0ffa8883b26549e8afe68804031aa5da856b7"
  end

  resource "mac-alias" do
    url "https://files.pythonhosted.org/packages/ea/a3/83b50f620d318a98363dc7e701fb94856eaaecc472e23a89ac625697b3ea/mac_alias-2.2.2.tar.gz"
    sha256 "c99c728eb512e955c11f1a6203a0ffa8883b26549e8afe68804031aa5da856b7"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dmgbuild", "--help"
  end
end
