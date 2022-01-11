class Zkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "https://github.com/zeek/package-manager/archive/v2.12.0.tar.gz"
  sha256 "cc56f0af93484c3ae419ecfcf32d847804d8dc1f6a0479b27683d7365e94a103"

  head "https://github.com/zeek/package-manager.git", branch: "master"

  depends_on "homebrew/core/python@3.9"
  depends_on "homebrew/core/zeek"

  resource "btest" do
    url "https://files.pythonhosted.org/packages/7c/90/75046372839622fe22413b9cfffdc94d4ef3077b7e7785e43a7272bc7036/btest-0.71.tar.gz"
    sha256 "d7b26918d82af75eea369d6c9c5d88ead79e89df51c4268cea749889087d39cc"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/fc/44/64e02ef96f20b347385f0e9c03098659cb5a1285d36c3d17c56e534d80cf/gitdb-4.0.9.tar.gz"
    sha256 "bac2fd45c0a1c9cf619e63a90d62bdc63892ef92387424b855792a6cabe789aa"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/70/b0/23e3245248f63eac75335828527016c7636c1780e7ad934a341970b47a78/GitPython-3.1.26.tar.gz"
    sha256 "fc8868f63a2e6d268fb25f481995ba185a85a66fcad126f039323ff6635669ee"
  end

  resource "semantic-version" do
    url "https://files.pythonhosted.org/packages/d4/52/3be868c7ed1f408cb822bc92ce17ffe4e97d11c42caafce0589f05844dd0/semantic_version-2.8.5.tar.gz"
    sha256 "d2cb2de0558762934679b9a104e82eca7af448c9f4974d1f3eeccff651df8a54"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/21/2d/39c6c57032f786f1965022563eec60623bb3e1409ade6ad834ff703724f3/smmap-5.0.0.tar.gz"
    sha256 "c840e62059cd3be204b0c9c9f74be2c09d5648eddd4580d9314c3ecde0b30936"
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
