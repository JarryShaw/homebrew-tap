class Macdaily < Formula
  include Language::Python::Virtualenv

  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://files.pythonhosted.org/packages/f2/3a/f2e52c31c05d69f4a4a2a6b29c2ebaf7717eaf595fdb28c7db2337257d2e/macdaily-2019.3.3.tar.gz"
  sha256 "784c4b1f2ea28ea6df1a9c82236ab52854ac38ce501ae76c8152d4da884f6ffb"
  revision 1

  head "https://github.com/JarryShaw/MacDaily.git", :branch => "master"

  devel do
    url "https://github.com/JarryShaw/MacDaily/archive/v2019.03.03.devel.tar.gz"
    sha256 "52774d186c437d4282c8148367763c1143c9c1acb446f8e35d612a7fa0d1bcda"
  end

  bottle :unneeded

  option "without-config", "build without config modification support"
  option "without-tree", "build without tree format support"
  option "without-ptyng", "build without alternative PTY support"

  depends_on "python"
  depends_on "expect" => :recommended

  resource "configupdater" do
    url "https://files.pythonhosted.org/packages/aa/af/069c7db438b9382a05fdaa6c90a2b44595dd7acdb1707848a0b8f2cbe1c1/ConfigUpdater-1.0.tar.gz"
    sha256 "a86d97bcb3f1012e10f13dc25a3b99019aa27abec414a047b6392255b2bbf4ca"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/76/27/8b859ac191f351c7612e4abed73dbcf55cf17e88fd36d65a75d2d4c519d4/dictdumper-0.7.0.post2.tar.gz"
    sha256 "dd7575db24e6f1a2b9278389df000a6db8fba4c45a92398c7e6d3e5fa575a3ab"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/c7/01/7c30b247cdc5ba29623faa5c8cf1f1bbf7e041783c340414b0ed7e067c64/psutil-5.5.1.tar.gz"
    sha256 "72cebfaa422b7978a1d3632b65ff734a34c6b34f4578b68a5c204d633756b810"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/b0/b8/833bfdf31657ee22484f8c672fd110678da40ff4a7c1c1404c276cbb56e0/ptyng-0.3.3.post1.tar.gz"
    sha256 "d55097f75605ce0c2026336ad198f9b76b0dfa71f765a0f84c3ab56a6bf0aed5"
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
    url "https://files.pythonhosted.org/packages/5d/79/617749a3e689dbb741da15cf3134fd52a47e3227d878a48573ece71df043/tbtrim-0.2.1.tar.gz"
    sha256 "b0810edfb5dcf94c5fe3335a8a8e18ae38a411f6ff6afca188c66ac72444218f"
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

    comp_path = Pathname.new(buildpath/"macdaily/comp/macdaily.bash-completion")
    comp_base = File.dirname comp_path
    bash_comp = File.join(comp_base, "macdaily")

    cp comp_path, bash_comp
    bash_completion.install bash_comp

    man_path = Pathname.glob(libexec/"lib/python?.?/site-packages/macdaily/man/*.1")
    dir_name = File.dirname man_path[0]
    dest = File.join(dir_name, "temp.1")

    man_path.each do |f|
      cp f, dest
      man1.install f
      mv dest, f
    end
  end

  def post_install
    f = File.new("/private/tmp/macdaily-launch.py", "w")
    f.write <<~EOS
      # -*- coding: utf-8 -*-

      from macdaily.cmd.launch import launch_askpass, launch_confirm

      launch_askpass(quiet=True, verbose=True)
      launch_confirm(quiet=True, verbose=True)
    EOS
    f.close

    system libexec/"bin/python", "/private/tmp/macdaily-launch.py"
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
