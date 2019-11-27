class Poseur < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 positional-only parameters syntax"
  homepage "https://github.com/JarryShaw/poseur#poseur"
  url "https://github.com/JarryShaw/poseur/archive/v0.4.2.tar.gz"
  sha256 "6e43dcf6ba572153eea536dd495af9a49bdf2936eacafb3b414c1e1caf000d4d"

  head "https://github.com/JarryShaw/poseur.git", :branch => "master"

  depends_on "python"

  resource "parso" do
    url "https://files.pythonhosted.org/packages/21/40/615957db4d178b7504c87b1a5b85fa5945b0b4fa5f5a845e31fc7aad6018/parso-0.5.1.tar.gz"
    sha256 "666b0ee4a7a1220f65d367617f2cd3ffddff3e205f3f16a0284df30e774c2a9c"
  end

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/5d/79/617749a3e689dbb741da15cf3134fd52a47e3227d878a48573ece71df043/tbtrim-0.2.1.tar.gz"
    sha256 "b0810edfb5dcf94c5fe3335a8a8e18ae38a411f6ff6afca188c66ac72444218f"
  end

  def install
    rm "setup.py"
    cp "scripts/setup.pypi.py", "setup.py"
    virtualenv_install_with_resources

    man1.install "share/poseur.1"
    bash_completion.install "share/poseur.bash-completion"
  end

  test do
    (testpath/"test.py").write <<~EOS
      def func_g(p_a, p_b=lambda p_a=1, /: p_a):
          pass
    EOS

    std_output = <<~EOS
      def _poseur_decorator(*poseur):
          """Positional-only arguments runtime checker.

          Args:
          - str, name of positional-only arguments

          Refs:
          - https://mail.python.org/pipermail/python-ideas/2017-February/044888.html

          """
          import functools
          def caller(func):
              @functools.wraps(func)
              def wrapper(*args, **kwargs):
                  for poseur_args in poseur:
                      if poseur_args in kwargs:
                          raise TypeError('%s() got an unexpected keyword argument %r' % (func.__name__, poseur_args))
                  return func(*args, **kwargs)
              return wrapper
          return caller


      def func_g(p_a, p_b=_poseur_decorator('p_a')(lambda p_a=1: p_a)):
          pass
    EOS

    system bin/"poseur", "--no-archive", "test.py"
    assert_match std_output, shell_output("cat test.py")
  end
end
