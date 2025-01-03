class Zkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "https://github.com/zeek/package-manager/archive/v3.0.1.tar.gz"
  sha256 "838f7e0022376cc58251603a072082e3603f73c051273ddaa41b711bcb9dfc40"

  head "https://github.com/zeek/package-manager.git", branch: "master"

  depends_on "homebrew/core/python@3.9"
  depends_on "homebrew/core/zeek"

  resource "btest" do
    url "https://files.pythonhosted.org/packages/c9/16/fb673331fcb1cc667bed0a47c582d44ee4a4cec244951b402f629db7d9cc/btest-1.2.tar.gz"
    sha256 "1d68141e13f8880f042f7066ccc7742f3d085d2c0af52355f670797029ac8d78"
  end

  resource "dill" do
    url "https://files.pythonhosted.org/packages/70/43/86fe3f9e130c4137b0f1b50784dd70a5087b911fe07fa81e53e0c4c47fea/dill-0.3.9.tar.gz"
    sha256 "81aa267dddf68cbfe8029c42ca9ec6a4ab3b22371d1c450abc54422577b4512c"
  end

  resource "gitdb" do
    url "https://files.pythonhosted.org/packages/72/94/63b0fc47eb32792c7ba1fe1b694daec9a63620db1e313033d18140c2320a/gitdb-4.0.12.tar.gz"
    sha256 "5ef71f855d191a3326fcfbc0d5da835f26b13fbcba60c32c21091c349ffdb571"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/c0/89/37df0b71473153574a5cdef8f242de422a0f5d26d7a9e231e6f169b4ad14/gitpython-3.1.44.tar.gz"
    sha256 "c87e30b26253bf5418b01b0660f818967f3c503193838337fe5e573331249269"
  end

  resource "multiprocess" do
    url "https://files.pythonhosted.org/packages/e9/34/1acca6e18697017ad5c8b45279b59305d660ecf2fbed13e5f406f69890e4/multiprocess-0.70.17.tar.gz"
    sha256 "4ae2f11a3416809ebc9a48abfc8b14ecce0652a0944731a1493a3c1ba44ff57a"
  end

  resource "semantic-version" do
    url "https://files.pythonhosted.org/packages/7d/31/f2289ce78b9b473d582568c234e104d2a342fd658cc288a7553d83bb8595/semantic_version-2.10.0.tar.gz"
    sha256 "bdabb6d336998cbb378d4b9db3a4b56a1e3235701dc05ea2690d9a997ed5041c"
  end

  resource "smmap" do
    url "https://files.pythonhosted.org/packages/44/cd/a040c4b3119bbe532e5b0732286f805445375489fceaec1f48306068ee3b/smmap-5.0.2.tar.gz"
    sha256 "26ea65a03958fa0c8a1c7e8c7a58fdc77221b8910f6be2131affade476898ad5"
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
