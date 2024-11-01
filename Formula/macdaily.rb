class Macdaily < Formula
  include Language::Python::Virtualenv

  desc "macOS Automated Package Manager"
  homepage "https://github.com/JarryShaw/MacDaily#macdaily"
  url "https://github.com/JarryShaw/MacDaily/archive/v2019.8.4.tar.gz"
  sha256 "08e5a96c2d6bf5206cd51adc627456e2023c33567f470b34d0cee83159de9885"

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
    url "https://files.pythonhosted.org/packages/2b/f4/603bd8a65e040b23d25b5843836297b0f4e430f509d8ed2ef8f072fb4127/ConfigUpdater-3.2.tar.gz"
    sha256 "9fdac53831c1b062929bf398b649b87ca30e7f1a735f3fbf482072804106306b"
  end

  resource "dictdumper" do
    url "https://files.pythonhosted.org/packages/0f/5f/c9c3c056f1a625bc57ead30bedaf971cac52f71d27f61544c3cb2046501f/dictdumper-0.8.4.post3.tar.gz"
    sha256 "6b43a720564f7ddf4fa1d2d3b5d74dacd372b5b4d758089626ed7ad674ea2fd4"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/26/10/2a30b13c61e7cf937f4adf90710776b7918ed0a9c434e2c38224732af310/psutil-6.1.0.tar.gz"
    sha256 "353815f59a7f64cdaca1c0307ee13558a0512f6db064e92fe833784f08539c7a"
  end

  resource "ptyng" do
    url "https://files.pythonhosted.org/packages/b0/b8/833bfdf31657ee22484f8c672fd110678da40ff4a7c1c1404c276cbb56e0/ptyng-0.3.3.post1.tar.gz"
    sha256 "d55097f75605ce0c2026336ad198f9b76b0dfa71f765a0f84c3ab56a6bf0aed5"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/31/51/99caf463dc7c18eb18dad1fffe465a3cf3ee50ac3d1dccbd1781336fe9c7/pathlib2-2.3.7.post1.tar.gz"
    sha256 "9fe0edad898b83c0c3e199c842b27ed216645d2e177757b2dd67384d4113c641"
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
