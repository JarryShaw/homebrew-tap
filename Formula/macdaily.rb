class Macdaily < Formula
  include Language::Python::Virtualenv

  version "2018.12.12"
  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://files.pythonhosted.org/packages/56/4a/4a2a69f2a5e67d2251082a239d457c5d880f0f1ffe30ad9c61231d4ff059/macdaily-2018.12.12.tar.gz"
  sha256 "1ef13a3049fdbca59b2a5f3192b5e2e8132dccf43004db02ae63ff3a45ccbccd"
  head "https://github.com/JarryShaw/MacDaily.git", :branch => "release"

  bottle :unneeded

  # bottle do
  #   cellar :any_skip_relocation
  #   sha256 "" => :mojave
  #   sha256 "" => :high_sierra
  #   sha256 "" => :sierra
  # end

  devel do
    url "https://codeload.github.com/JarryShaw/MacDaily/tar.gz/v2018.12.12"
    sha256 "5caed8775d0916401fe0029fcd6b0195473163d2d1bacbf37ab895764b04577f"
  end

  depends_on "python"
  depends_on "expect" => :recommended
  depends_on "theseal/ssh-askpass/ssh-askpass" => :optional

  option "without-config", "build without config modification support"
  option "without-tree", "build without tree format support"
  option "without-ptyng", "build without alternative PTY support"

  resource "configupdater" do
    url "https://files.pythonhosted.org/packages/aa/af/069c7db438b9382a05fdaa6c90a2b44595dd7acdb1707848a0b8f2cbe1c1/ConfigUpdater-1.0.tar.gz"
    sha256 "a86d97bcb3f1012e10f13dc25a3b99019aa27abec414a047b6392255b2bbf4ca"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/e3/a9/41c93d7108131852f39a094367114f83246d12020a8d1a246137e6277e04/dictdumper-0.7.0.tar.gz"
    sha256 "ea728ce02920a3aed052c1a8676c7098359701e298918efbc62c0eba846f807f"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/ad/59/293b9f3ba95ce2ca10ac0bcab99d41b3507bc4bbbbd636e6dff05576205a/ptyng-0.3.0.post1.tar.gz"
    sha256 "298e1dc6eb15ccff219f1a05139b3b407ec22226d4a445966474345a1e9048d0"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/e3/58/0eae6e4466e5abf779d7e2b71fac7fba5f59e00ea36ddb3ed690419ccb0f/psutil-5.4.8.tar.gz"
    sha256 "6e265c8f3da00b015d24b842bfeb111f856b13d24f2c57036582568dc650d6c3"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/bf/d7/a2568f4596b75d2c6e2b4094a7e64f620decc7887f69a1f2811931ea15b9/pathlib2-2.3.3.tar.gz"
    sha256 "25199318e8cc3c25dcb45cbe084cc061051336d5a9ea2a12448d3d8cb748f742"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "subprocess32" do
    url "https://files.pythonhosted.org/packages/be/2b/beeba583e9877e64db10b52a96915afc0feabf7144dcbf2a0d0ea68bf73d/subprocess32-3.5.3.tar.gz"
    sha256 "6bc82992316eef3ccff319b5033809801c0c3372709c5f6985299c88ac7225c3"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    if build.with?("config")
      venv.pip_install resource("configupdater")
    end

    if build.with?("tree")
      venv.pip_install resource("dictdumper")
    end

    if build.with?("ptyng")
      venv.pip_install resource("ptyng")

      exitcode = `#{libexec}/"bin/python" -c "print(__import__('os').system('ps axo pid=,stat= > /dev/null 2>&1'))"`
      if !( exitcode =~ /0/ )
        venv.pip_install resource("psutil")
      end
    end

    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    if ( version =~ /3.4/ )
      %w[pathlib2 six subprocess32].each do |r|
        venv.pip_install resource(r)
      end
    end
    venv.pip_install_and_link buildpath

    man_path = Pathname.glob(libexec/"lib/python?.?/site-packages/macdaily/man/*.1")
    dir_name = File.dirname man_path[0]
    dest = File.join(dir_name, "temp.1")

    man_path.each do |f|
      FileUtils.cp f, dest
      man1.install f
      FileUtils.mv dest, f
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
