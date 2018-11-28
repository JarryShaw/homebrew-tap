class Macdaily < Formula
  include Language::Python::Virtualenv

  version "2018.11.28"
  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://files.pythonhosted.org/packages/f3/d1/4c9fff3fdd2dd375583bc813ddbff44933770c30a39d01688aed644efbec/macdaily-2018.11.28.tar.gz"
  sha256 "557978d677774e0b0b32ab63eef7189a2df494ed9f56e85f6d2df8cd17af95e6"
  head "https://github.com/JarryShaw/MacDaily.git", :branch => "release"

  bottle :unneeded

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "" => :mojave
  #   sha256 "" => :high_sierra
  #   sha256 "" => :sierra
  # end

  devel do
    url "https://codeload.github.com/JarryShaw/MacDaily/tar.gz/v2018.11.28"
    sha256 "94d66460e690554220e06ecaafbb6360d5c3674d0bd7daa0c64b3338acabab8c"
  end

  depends_on "python"
  depends_on "expect" => :recommended
  depends_on "theseal/ssh-askpass/ssh-askpass" => :optional

  resource "configupdater" do
    url "https://files.pythonhosted.org/packages/54/b8/1aa82f89b77045c897c35d3f2f28c7559282fd422018c0377efc362f56d1/ConfigUpdater-0.3.2.tar.gz"
    sha256 "f8e832a1a40faca6aa9abdc3069cc0fb9021580dcef96cbe1aad055bc08ab865"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/e7/f7/fa8b1c68cb02270e58852c178d4d4eea099e2806e0da9ca7fcc7920b4463/dictdumper-0.6.5.post2.tar.gz"
    sha256 "96d4d0910662d8e21e2c1900bb5438dbb2562e680bda34be2d9cf1434e8b0416"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/02/4b/2d6c1543657cddf4a061aa9fb86e20b354706e37868a76d9691740d1fd16/ptyng-0.2.1.post1.tar.gz"
    sha256 "a199c0a60eaf3d9e10aad97d858f0feb032e87ccdefe80592146cc95b65362fd"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/e3/58/0eae6e4466e5abf779d7e2b71fac7fba5f59e00ea36ddb3ed690419ccb0f/psutil-5.4.8.tar.gz"
    sha256 "6e265c8f3da00b015d24b842bfeb111f856b13d24f2c57036582568dc650d6c3"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/db/a8/7d6439c1aec525ed70810abee5b7d7f3aa35347f59bc28343e8f62019aa2/pathlib2-2.3.2.tar.gz"
    sha256 "8eb170f8d0d61825e09a95b38be068299ddeda82f35e96c3301a8a5e7604cb83"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "subprocess32" do
    url "https://files.pythonhosted.org/packages/be/2b/beeba583e9877e64db10b52a96915afc0feabf7144dcbf2a0d0ea68bf73d/subprocess32-3.5.3.tar.gz"
    sha256 "6bc82992316eef3ccff319b5033809801c0c3372709c5f6985299c88ac7225c3"
  end

  def install
    virtualenv_install_with_resources
    man_path = Pathname.glob(libexec/"lib/python?.?/site-packages/macdaily/man/*.1")
    man_path.each do |f|
      man1.install f
    end
  end

  # def post_install
  #   text = <<~EOS
  #     To run postinstall process, please directly call
  #       `macdaily launch askpass confirm`
  #   EOS
  #   puts text
  # end

  def caveats
    text = <<~EOS
      MacDaily has been installed as
        #{HOMEBREW_PREFIX}/bin/macdaily

      Alias executables `md-update`, `md-uninstall`, etc. equal to
      `macdaily update`, `macdaily uninstall`, etc., respectively,
      have been also installed into #{HOMEBREW_PREFIX}/bin/

      Configuration file locates at ~/.dailyrc, please directly run
      `macdaily config --interactive` command to set up your runtime
      specifications.

      For more information, check out `macdaily help` command. Online
      documentations available at GitHub repository.

      To run postinstall process, please directly call
        `macdaily launch askpass confirm`

      See: https://github.com/JarryShaw/MacDaily#generals
    EOS
    text
  end

  test do
    system bin/"macdaily", "--help"
  end
end
