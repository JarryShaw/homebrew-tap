class Macdaily < Formula
  include Language::Python::Virtualenv

  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://github.com/JarryShaw/MacDaily/archive/v1.7.2.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  head "https://github.com/JarryShaw/MacDaily.git", branch: "master"

  option "without-config", "Build without config modification support"
  option "without-tree", "Build without tree format support"
  option "without-ptyng", "Build without alternative PTY support"

  depends_on "homebrew/core/python@3.9"
  depends_on "homebrew/core/expect" => :recommended
  depends_on "homebrew/core/cowsay" => :optional
  depends_on "homebrew/core/fortune" => :optional
  depends_on "homebrew/core/lolcat" => :optional

  resource "ConfigUpdater" do
    url "https://files.pythonhosted.org/packages/9b/0e/0e730b2b3691f8374a74833a48b90616eb4de61f197d924cebd8d2e07d00/ConfigUpdater-3.0.1.tar.gz"
    sha256 "372a6a6ef598a118ec17927bec9486a7d36f44ccd3e641e879e0bf998b70924e"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/ff/89/4e34c60426206e28a49964e86eda05ae1d089f9e9c6dcd3dfca643de5cb4/dictdumper-0.8.4.post2.tar.gz"
    sha256 "362a404d1b3c3d20afaf585adff9897116f6ebc8c747b9248bf323a8fedcabda"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/47/b6/ea8a7728f096a597f0032564e8013b705aa992a0990becd773dcc4d7b4a7/psutil-5.9.0.tar.gz"
    sha256 "869842dbd66bb80c3217158e629d6fceaecc3a3166d3d1faee515b05dd26ca25"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/b0/b8/833bfdf31657ee22484f8c672fd110678da40ff4a7c1c1404c276cbb56e0/ptyng-0.3.3.post1.tar.gz"
    sha256 "d55097f75605ce0c2026336ad198f9b76b0dfa71f765a0f84c3ab56a6bf0aed5"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/d0/74/0fefd1dd0c159cf91bdc43f9dbfdaeadb231d9bfc9d7111c4e03e893291b/pathlib2-2.3.7.post0.tar.gz"
    sha256 "3207eb068c994a04998c42a34ae01c81c8d1d50eb88d7371f57fee61d1822302"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "subprocess32" do
    url "https://files.pythonhosted.org/packages/32/c8/564be4d12629b912ea431f1a50eb8b3b9d00f1a0b1ceff17f266be190007/subprocess32-3.5.4.tar.gz"
    sha256 "eb2937c80497978d181efa1b839ec2d9622cf9600a039a79d0e108d1f9aec79d"
  end

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/85/62/89756f5d2d61691591c4293fd4cc1fbb3aab1466251c7319fe60dd08fb27/tbtrim-0.3.1.tar.gz"
    sha256 "b6285ac02e9a7b78fab97de65668fe2def0f5d8783b0e0dfcb4b7c0a635b3d11"
  end

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resource("tbtrim")

    venv.pip_install resource("ConfigUpdater") if build.with?("config")

    venv.pip_install resource("dictdumper") if build.with?("tree")

    if build.with?("ptyng")
      venv.pip_install resource("ptyng")

      exitcode = `#{libexec}/"bin/python" -c "print(__import__('os').system('ps axo pid=,stat= > /dev/null 2>&1'))"`
      venv.pip_install resource("psutil") unless /0/.match?(exitcode)
    end

    version = Language::Python.major_minor_version "python3"
    if /3.4/.match?(version)
      %w[pathlib2 six subprocess32].each do |r|
        venv.pip_install resource(r)
      end
    end
    venv.pip_install_and_link buildpath

    comp_path = libexec/"lib/python#{version}/site-packages/macdaily/comp/macdaily.bash-completion"
    bash_completion.install_symlink comp_path => "macdaily"

    man_path = Pathname.glob(libexec/"lib/python#{version}/site-packages/macdaily/man/*.8")
    man_path.each do |f|
      man8.install_symlink f
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
    <<~EOS
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
  end

  test do
    system bin/"macdaily", "--help"
  end
end
