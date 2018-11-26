class Macdaily < Formula
  include Language::Python::Virtualenv

  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://files.pythonhosted.org/packages/51/39/24e3852917c249f8aca1cd75589d604c1ec14ffd06dafadbd05be4771d54/macdaily-2018.11.25.post2.tar.gz"
  sha256 "4436233eaf4c85c7f8201852e307cbdfea6e95d037c7fd62bea8f2724a11716b"
  head "https://github.com/JarryShaw/MacDaily.git", :branch => "release"

  bottle :unneeded

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "" => :mojave
  #   sha256 "" => :high_sierra
  #   sha256 "" => :sierra
  # end

  devel do
    url "https://codeload.github.com/JarryShaw/MacDaily/tar.gz/v2018.11.25.post2"
    sha256 "d2e86b04e03707b2c1657569b2fae4e1e97b481394288ed1a652b01f8995f7d0"
  end

  depends_on "python"

  depends_on "expect" => :recommended

  resource "configupdater" do
    url "https://files.pythonhosted.org/packages/54/b8/1aa82f89b77045c897c35d3f2f28c7559282fd422018c0377efc362f56d1/ConfigUpdater-0.3.2.tar.gz"
    sha256 "f8e832a1a40faca6aa9abdc3069cc0fb9021580dcef96cbe1aad055bc08ab865"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/e7/f7/fa8b1c68cb02270e58852c178d4d4eea099e2806e0da9ca7fcc7920b4463/dictdumper-0.6.5.post2.tar.gz"
    sha256 "96d4d0910662d8e21e2c1900bb5438dbb2562e680bda34be2d9cf1434e8b0416"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/e3/58/0eae6e4466e5abf779d7e2b71fac7fba5f59e00ea36ddb3ed690419ccb0f/psutil-5.4.8.tar.gz"
    sha256 "6e265c8f3da00b015d24b842bfeb111f856b13d24f2c57036582568dc650d6c3"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/02/4b/2d6c1543657cddf4a061aa9fb86e20b354706e37868a76d9691740d1fd16/ptyng-0.2.1.post1.tar.gz"
    sha256 "a199c0a60eaf3d9e10aad97d858f0feb032e87ccdefe80592146cc95b65362fd"
  end

  def install
    virtualenv_install_with_resources
    man_path = Pathname.glob(libexec/"lib/python?.?/site-packages/macdaily/man/*.1")
    man_path.each_child do |f|
      man1.install f
    end
  end

  def post_install
    system bin/"macdaily", "launch", "--all"
  end

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

      See: https://github.com/JarryShaw/MacDaily#generals
    EOS
    text
  end

  test do
    system bin/"macdaily", "--help"
  end
end
