class F2format < Formula
  include Language::Python::Virtualenv

  desc "Back-port compiler for Python 3.6 f-string literals"
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://github.com/JarryShaw/f2format/archive/v0.5.1.tar.gz"
  sha256 "1114d8b67f905d9fa962739475a98b5ae7088576627e02c7cf8cb978d0b46d33"

  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  depends_on "python"

  resource "parso" do
    url "https://files.pythonhosted.org/packages/79/52/70d0bb8a1f4b1475a603b4b1484bb351edda30846996fc93fe1976948fef/parso-0.4.0.tar.gz"
    sha256 "2e9574cb12e7112a87253e14e2c380ce312060269d04bd018478a3c92ea9a376"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/bf/d7/a2568f4596b75d2c6e2b4094a7e64f620decc7887f69a1f2811931ea15b9/pathlib2-2.3.3.tar.gz"
    sha256 "25199318e8cc3c25dcb45cbe084cc061051336d5a9ea2a12448d3d8cb748f742"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  def install
    # virtualenv_install_with_resources
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resource("parso")

    version = Language::Python.major_minor_version "python3"
    if version =~ /3.[34]/
      %w[pathlib2 six].each do |r|
        venv.pip_install resource(r)
      end
    end
    venv.pip_install_and_link buildpath

    man1.install "man/f2format.1"
    bash_completion.install "comp/f2format.bash-completion"
  end

  test do
    (testpath/"test.py").write <<~EOS
      var = f'foo{(1+2)*3:>5}bar{"a", "b"!r}boo'
    EOS

    std_output = <<~EOS
      var = 'foo{:>5}bar{!r}boo'.format((1+2)*3, ("a", "b"))
    EOS

    system bin/"f2format", "--no-archive", "test.py"
    assert_match std_output, shell_output("cat test.py")
  end
end
