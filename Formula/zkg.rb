class Zkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "https://github.com/zeek/package-manager/archive/v2.14.0.tar.gz"
  sha256 "a4c3d4a122f45e23247ffa26d36e585c5a0e6e5ac1de5cdcfdd58c3818a4d2eb"

  head "https://github.com/zeek/package-manager.git", branch: "master"

  depends_on "homebrew/core/python@3.9"
  depends_on "homebrew/core/zeek"

  resource "btest" do
    url "https://files.pythonhosted.org/packages/72/9e/a52550373fac3cc7bf639f400bb894830630322d8a3ad19ddc75f27f6c40/btest-1.1.tar.gz"
    sha256 "312eef873aabda0a39ce6e716c1553e03478eaa0686456f63270205e049fa6bb"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/4b/47/dc98f3d5d48aa815770e31490893b92c5f1cd6c6cf28dd3a8ae0efffac14/gitdb-4.0.10.tar.gz"
    sha256 "6eb990b69df4e15bad899ea868dc46572c3f75339735663b81de79b06f17eb9a"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/b3/45/cee7af549b6fa33f04531e402693a772b776cd9f845a2cbeca99cfac3331/GitPython-3.1.38.tar.gz"
    sha256 "4d683e8957c8998b58ddb937e3e6cd167215a180e1ffd4da769ab81c620a89fe"
  end

  resource "semantic-version" do
    url "https://files.pythonhosted.org/packages/7d/31/f2289ce78b9b473d582568c234e104d2a342fd658cc288a7553d83bb8595/semantic_version-2.10.0.tar.gz"
    sha256 "bdabb6d336998cbb378d4b9db3a4b56a1e3235701dc05ea2690d9a997ed5041c"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/88/04/b5bf6d21dc4041000ccba7eb17dd3055feb237e7ffc2c20d3fae3af62baa/smmap-5.0.1.tar.gz"
    sha256 "dceeb6c0028fdb6734471eb07c0cd2aae706ccaecab45965ee83f11c8d3b1f62"
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
