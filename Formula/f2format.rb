class F2format < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.6 f-string literals"
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://github.com/JarryShaw/f2format/archive/v0.7.3.tar.gz"
  sha256 "f8c43992c28b218bac8e91d935b4195c17d5c76c5393ef8116dd272cc764b1ed"

  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  depends_on "python"

  resource "parso" do
    url "https://files.pythonhosted.org/packages/68/88/99c08caaaed740853a2db12294e6a30e7a83a2d316585b8a3ea6e24c415d/parso-0.5.0.tar.gz"
    sha256 "db5881df1643bf3e66c097bfd8935cf03eae73f4cb61ae4433c9ea4fb6613446"
  end

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/5d/79/617749a3e689dbb741da15cf3134fd52a47e3227d878a48573ece71df043/tbtrim-0.2.1.tar.gz"
    sha256 "b0810edfb5dcf94c5fe3335a8a8e18ae38a411f6ff6afca188c66ac72444218f"
  end

  def install
    virtualenv_install_with_resources
    man1.install "share/f2format.1"
    bash_completion.install "share/f2format.bash-completion"
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
