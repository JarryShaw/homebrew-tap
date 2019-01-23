class F2format < Formula
  include Language::Python::Virtualenv

  version "0.4.3"
  desc "Back-port compiler for Python 3.6 f-string literals"
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://files.pythonhosted.org/packages/52/93/bb5984cc8cb711d49eefada6405ad4044da50b3c347056997453d52a86e0/f2format-0.4.3.tar.gz"
  sha256 "ec05c3499d0948c9692d875c9e19e58ccde61ed1138b6b3e5743e193bf8bbc82"

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
    url "https://files.pythonhosted.org/packages/00/be/c3769a5d6a179c42eba04186dc7efeb165edf92f7b1582ccfe81cb17d7f9/typed-ast-1.2.0.tar.gz"
    sha256 "b4726339a4c180a8b6ad9d8b50d2b6dc247e1b79b38fe2290549c98e82e4fd15"
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
