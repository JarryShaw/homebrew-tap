class Poseur < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 positional-only parameters syntax"
  homepage "https://github.com/pybpc/poseur#poseur"
  url "https://github.com/pybpc/poseur/archive/v1.7.1.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  head "https://github.com/pybpc/poseur.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "bpc-utils" do
    url "https://files.pythonhosted.org/packages/fe/f9/233bb16668b2be1ea8be2d5c81466e271df40c92b9cf02e03c6546b5fb6d/bpc-utils-0.9.1.tar.gz"
    sha256 "5bfd5e5fd460674b207f9786f7a0db315a06fff1de0c9b6b8c17d0ce07ad865b"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/a2/0e/41f0cca4b85a6ea74d66d2226a7cda8e41206a624f5b330b958ef48e2e52/parso-0.8.3.tar.gz"
    sha256 "8c07be290bb59f03588915921e29e8a50002acaf2cdc5fa0e0114f91709fafa0"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/0d/4a/60ba3706797b878016f16edc5fbaf1e222109e38d0fa4d7d9312cb53f8dd/typing_extensions-4.0.1.tar.gz"
    sha256 "4ca091dea149f945ec56afb48dae714f21e8692ef22a395223bcd328961b6a0e"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/a2/0e/41f0cca4b85a6ea74d66d2226a7cda8e41206a624f5b330b958ef48e2e52/parso-0.8.3.tar.gz"
    sha256 "8c07be290bb59f03588915921e29e8a50002acaf2cdc5fa0e0114f91709fafa0"
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
