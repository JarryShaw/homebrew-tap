class Poseur < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 positional-only parameters syntax"
  homepage "https://github.com/pybpc/poseur#poseur"
  url "https://github.com/pybpc/poseur/archive/v1.7.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  head "https://github.com/pybpc/poseur.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "bpc-utils" do
    url "https://files.pythonhosted.org/packages/fe/f9/233bb16668b2be1ea8be2d5c81466e271df40c92b9cf02e03c6546b5fb6d/bpc-utils-0.9.1.tar.gz"
    sha256 "5bfd5e5fd460674b207f9786f7a0db315a06fff1de0c9b6b8c17d0ce07ad865b"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/e0/a2/3786c568fc8e9f64b9f7143e4c3904e61a8c5cb17260f22a6a3019d80c02/parso-0.5.2.tar.gz"
    sha256 "55cf25df1a35fd88b878715874d2c4dc1ad3f0eebd1e0266a67e1f55efccfbe1"
  end

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/85/62/89756f5d2d61691591c4293fd4cc1fbb3aab1466251c7319fe60dd08fb27/tbtrim-0.3.1.tar.gz"
    sha256 "b6285ac02e9a7b78fab97de65668fe2def0f5d8783b0e0dfcb4b7c0a635b3d11"
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
              *poseur (List[str]): Name of positional-only arguments.

          See Also:
              https://mail.python.org/pipermail/python-ideas/2017-February/044888.html

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
