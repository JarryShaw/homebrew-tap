class Macdaily < Formula
  include Language::Python::Virtualenv

  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://files.pythonhosted.org/packages/6a/63/57485b6c8bfd0dde324155dfad7155252b91149f3412c9a3c199552edf87/macdaily-2019.4.7.post1.tar.gz"
  version "2019.4.7"
  sha256 "4b8c5a792f8e73563be44f3161ec37775d61a1283d2acab34f94b52ba3172dc2"
  revision 2

  head "https://github.com/JarryShaw/MacDaily.git", :branch => "master"

  devel do
    url "https://github.com/JarryShaw/MacDaily/archive/v2019.4.7.post1.c7250d-devel.tar.gz"
    version "2019.4.7_1.c7250d"
    sha256 "f630fbf6ab99a12b4597c65277bae8ceb1aea380b78fe1ce36a80c6ef9af8327"
  end

  option "without-config", "Build without config modification support"
  option "without-tree", "Build without tree format support"
  option "without-ptyng", "Build without alternative PTY support"

  depends_on "python"
  depends_on "expect" => :recommended
  depends_on "cowsay" => :optional
  depends_on "fortune" => :optional
  depends_on "lolcat" => :optional

  resource "configupdater" do
    url "https://files.pythonhosted.org/packages/aa/af/069c7db438b9382a05fdaa6c90a2b44595dd7acdb1707848a0b8f2cbe1c1/ConfigUpdater-1.0.tar.gz"
    sha256 "a86d97bcb3f1012e10f13dc25a3b99019aa27abec414a047b6392255b2bbf4ca"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/76/27/8b859ac191f351c7612e4abed73dbcf55cf17e88fd36d65a75d2d4c519d4/dictdumper-0.7.0.post2.tar.gz"
    sha256 "dd7575db24e6f1a2b9278389df000a6db8fba4c45a92398c7e6d3e5fa575a3ab"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/2f/b8/11ec5006d2ec2998cb68349b8d1317c24c284cf918ecd6729739388e4c56/psutil-5.6.1.tar.gz"
    sha256 "fa0a570e0a30b9dd618bffbece590ae15726b47f9f1eaf7518dfb35f4d7dcd21"
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

    version = Language::Python.major_minor_version "python3"
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

    man_path = Pathname.glob(libexec/"lib/python#{version}/site-packages/macdaily/man/*.8")
    dir_name = File.dirname man_path[0]
    dest = File.join(dir_name, "temp.8")

    man_path.each do |f|
      cp f, dest
      man8.install f
      mv dest, f
    end
  end

  def post_install
    # set environment variables
    ENV["NULL_PASSWORD"] = "true"
    ENV["MACDAILY_LOGDIR"] = "/tmp"
    ENV["MACDAILY_NO_CONFIG"] = "true"

    # relaunch askpass & confirm utilities
    system bin/"macdaily", "launch", "askpass", "confirm", "--quiet", "--no-cleanup"
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

      Due to restrictions of Homebrew, please manually run
      `macdaily launch daemons` command to relaunch your scheduled
      tasks of MacDaily.

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
