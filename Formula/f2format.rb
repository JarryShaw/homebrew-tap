class F2format < Formula
  include Language::Python::Virtualenv

  version "0.4.2"
  desc "Back-port compiler for Python 3.6 f-string literals"
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://files.pythonhosted.org/packages/3e/a9/68646c00871407f5d57e6c8e4e88c34168644695b28537c604466109f04a/f2format-0.4.2.tar.gz"
  sha256 "56571acb42ac072969648c190fc820b01d0164272b305c6a64e0803de81210e3"

  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  bottle :unneeded

  depends_on "python"

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/bf/d7/a2568f4596b75d2c6e2b4094a7e64f620decc7887f69a1f2811931ea15b9/pathlib2-2.3.3.tar.gz"
    sha256 "25199318e8cc3c25dcb45cbe084cc061051336d5a9ea2a12448d3d8cb748f742"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "typed-ast" do
    url "https://files.pythonhosted.org/packages/9d/f8/78010480255fc6a1e545d1e74389128c1a4f11905b9ab16a7ef6c956c704/typed-ast-1.1.1.tar.gz"
    sha256 "6cb25dc95078931ecbd6cbcc4178d1b8ae8f2b513ae9c3bd0b7f81c2191db4c6"
  end

  def install
    # virtualenv_install_with_resources
    venv = virtualenv_create(libexec, "python3")

    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    if version =~ /3.[34]/
      %w[pathlib2 six].each do |r|
        venv.pip_install resource(r)
      end
    end

    venv.pip_install resource("typed-ast")
    # if version =~ /3.[345]/
    #   venv.pip_install resource("typed-ast")
    # end
    venv.pip_install_and_link buildpath
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
