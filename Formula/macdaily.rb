class Macdaily < Formula
  include Language::Python::Virtualenv

  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://files.pythonhosted.org/packages/6b/32/621962b8489a300acb7b6802bd83095dfcdae46e3f2a66c56603f3febe36/macdaily-2019.1.25.tar.gz"
  sha256 "401eb23c77f6546aa39449adf4466ca1978198586204c02d2006106e696db066"

  head "https://github.com/JarryShaw/MacDaily.git", :branch => "master"

  devel do
    url "https://github.com/JarryShaw/MacDaily/archive/v2019.01.25.devel.tar.gz"
    sha256 "1c7f1829fc736b3c43814d2d3ff2d826b3e293088d8f286ea5c574164b130345"
  end

  bottle :unneeded

  option "without-config", "build without config modification support"
  option "without-tree", "build without tree format support"
  option "without-ptyng", "build without alternative PTY support"

  depends_on "python"
  depends_on "expect" => :recommended
  depends_on "jarryshaw/tap/askpass" => :optional
  depends_on "jarryshaw/tap/confirm" => :optional
  depends_on "theseal/ssh-askpass/ssh-askpass" => :optional

  resource "configupdater" do
    url "https://files.pythonhosted.org/packages/aa/af/069c7db438b9382a05fdaa6c90a2b44595dd7acdb1707848a0b8f2cbe1c1/ConfigUpdater-1.0.tar.gz"
    sha256 "a86d97bcb3f1012e10f13dc25a3b99019aa27abec414a047b6392255b2bbf4ca"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/35/2f/f183561a516643a0fc0117a18f2d921ef9f3a0cb4604a72f0d1e8089028c/dictdumper-0.7.0.post1.tar.gz"
    sha256 "33812e46a142215fef2cc1eb788af532828ccfd29bfe0c623d4616110108f720"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/6e/a0/833bcbcede5141cc5615e50c7cc5b960ce93d9c9b885fbe3b7d36e48a2d4/psutil-5.5.0.tar.gz"
    sha256 "1aba93430050270750d046a179c5f3d6e1f5f8b96c20399ba38c596b28fc4d37"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/f7/66/249b152cf8dc7b93e361d1f2b333c028fc45eb5813747cd8a049e2750f52/ptyng-0.3.3.tar.gz"
    sha256 "dbdcbd4967b6928dc4bb58c7809d400b670d366ea24992ec8c6fd5e6c5608a2b"
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

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/34/71/6c8f16a0773497d9bf601b8839b6ddac4e0a9af8ef4394110ecb80d5b648/tbtrim-0.2.0.tar.gz"
    sha256 "78115ce0499b87ac2315e377ba076ec464ef2fa479c2243e5be1bf7a5a4c2db1"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resource("tbtrim")

    if build.with?("config")
      venv.pip_install resource("configupdater")
    end

    if build.with?("tree")
      venv.pip_install resource("dictdumper")
    end

    if build.with?("ptyng")
      venv.pip_install resource("ptyng")

      exitcode = `#{libexec}/"bin/python" -c "print(__import__('os').system('ps axo pid=,stat= > /dev/null 2>&1'))"`
      if exitcode !~ /0/
        venv.pip_install resource("psutil")
      end
    end

    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    if version =~ /3.4/
      %w[pathlib2 six subprocess32].each do |r|
        venv.pip_install resource(r)
      end
    end
    venv.pip_install_and_link buildpath

    man_path = Pathname.glob(libexec/"lib/python?.?/site-packages/macdaily/man/*.1")
    dir_name = File.dirname man_path[0]
    dest = File.join(dir_name, "temp.1")

    man_path.each do |f|
      cp f, dest
      man1.install f
      mv dest, f
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
