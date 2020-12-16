class Zkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "https://github.com/zeek/package-manager/archive/v2.6.0.tar.gz"
  sha256 "32ba879d80234253d4f410cfd16c944b7d43eeca43c9eaf9182e5d4922535295"

  head "https://github.com/zeek/package-manager.git", branch: "master"

  depends_on "homebrew/core/python@3.9"
  depends_on "homebrew/core/zeek"

  resource "btest" do
    url "https://files.pythonhosted.org/packages/c5/b1/78e0be3836fee821c305c4864328b6163922039c2d7ce503599038077ec6/btest-0.65.tar.gz"
    sha256 "d368045c6c6a9f050924f5c23d55d1ca15f274eaaa5e8e18a09b89561ab94e42"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/d1/05/eaf2ac564344030d8b3ce870b116d7bb559020163e80d9aa4a3d75f3e820/gitdb-4.0.5.tar.gz"
    sha256 "c9e1f2d0db7ddb9a704c2a0217be31214e91a4fe1dea1efad19ae42ba0c285c9"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/85/3d/ee9aa9c77a3c0e9074461d2d8da86c3564ed96abd28fa099dc3e05338a72/GitPython-3.1.11.tar.gz"
    sha256 "befa4d101f91bad1b632df4308ec64555db684c360bd7d2130b4807d49ce86b8"
  end

  resource "semantic-version" do
    url "https://files.pythonhosted.org/packages/d4/52/3be868c7ed1f408cb822bc92ce17ffe4e97d11c42caafce0589f05844dd0/semantic_version-2.8.5.tar.gz"
    sha256 "d2cb2de0558762934679b9a104e82eca7af448c9f4974d1f3eeccff651df8a54"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/75/fb/2f594e5364f9c986b2c89eb662fc6067292cb3df2b88ae31c939b9138bb9/smmap-3.0.4.tar.gz"
    sha256 "9c98bbd1f9786d22f14b3d4126894d56befb835ec90cef151af566c7e19b5d24"
  end

  def install
    virtualenv_install_with_resources
  end

  # def post_install
  #   system bin/"zkg", "autoconfig"
  # end

  def caveats
    <<~EOS
      zkg has been installed as
        #{HOMEBREW_PREFIX}/bin/zkg

      To perform postinstall process, please directly call the
      following command: `zkg autoconfig`.

      Configuration file locates at ~/.zkg/config, please
      run `zkg config` command to set up your runtime
      specifications.

      For more information, check out `zkg --help` command.
      Online documentations available at GitHub repository.

      See: https://docs.zeek.org/projects/package-manager
    EOS
  end

  test do
    system bin/"zkg", "--help"
  end
end
