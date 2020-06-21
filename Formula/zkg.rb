class Zkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "https://github.com/zeek/package-manager/archive/v2.1.2.tar.gz"
  sha256 "db79517f0f68b8f83f583f899bc1e7757942667996283a5e49b64898911fd404"

  head "https://github.com/zeek/package-manager.git", :branch => "master"

  depends_on "homebrew/core/python@3.8"
  depends_on "homebrew/core/zeek"

  resource "btest" do
    url "https://files.pythonhosted.org/packages/26/00/f60440c939ab30e11cc55b6fc6463c7e9ec583a9ce7d6c5c2d80dff676a6/btest-0.61.tar.gz"
    sha256 "8d8ee1723a3a55406911b3771ba5ae5247a5c34bf17c2222531660f1f4cad30c"
  end

  resource "configparser" do
    url "https://files.pythonhosted.org/packages/e5/7c/d4ccbcde76b4eea8cbd73b67b88c72578e8b4944d1270021596e80b13deb/configparser-5.0.0.tar.gz"
    sha256 "2ca44140ee259b5e3d8aaf47c79c36a7ab0d5e94d70bd4105c03ede7a20ea5a1"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/d1/05/eaf2ac564344030d8b3ce870b116d7bb559020163e80d9aa4a3d75f3e820/gitdb-4.0.5.tar.gz"
    sha256 "c9e1f2d0db7ddb9a704c2a0217be31214e91a4fe1dea1efad19ae42ba0c285c9"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/5b/ef/96dd6b06400821bbad3f7e275f4a4f88af324124c5c04958e2f2c14ce2c8/GitPython-3.1.3.tar.gz"
    sha256 "e107af4d873daed64648b4f4beb89f89f0cfbe3ef558fc7821ed2331c2f8da1a"
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
    text = <<~EOS
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
    text
  end

  test do
    system bin/"zkg", "--help"
  end
end
