class F2format < Formula
  include Language::Python::Virtualenv

  desc "Back-port compiler for Python 3.6 f-string literals"
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://github.com/JarryShaw/f2format/archive/v0.7.0.tar.gz"
  sha256 "c8ec5e83219516ce15f2067ace267fe0f3a6e8db64beed9062248c449bac45ab"

  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  depends_on "python"

  resource "parso" do
    url "https://files.pythonhosted.org/packages/79/52/70d0bb8a1f4b1475a603b4b1484bb351edda30846996fc93fe1976948fef/parso-0.4.0.tar.gz"
    sha256 "2e9574cb12e7112a87253e14e2c380ce312060269d04bd018478a3c92ea9a376"
  end

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/5d/79/617749a3e689dbb741da15cf3134fd52a47e3227d878a48573ece71df043/tbtrim-0.2.1.tar.gz"
    sha256 "b0810edfb5dcf94c5fe3335a8a8e18ae38a411f6ff6afca188c66ac72444218f"
  end

  def install
    virtualenv_install_with_resources
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
