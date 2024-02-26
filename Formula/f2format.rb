class F2format < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.6 f-string literals"
  homepage "https://github.com/pybpc/f2format#f2format"
  url "https://github.com/pybpc/f2format/archive/v0.8.7.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  head "https://github.com/pybpc/f2format.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "bpc-utils" do
    url "https://files.pythonhosted.org/packages/c8/b7/8131c9884d2d79c5b68d6ad8856aa7e7d89543a4dda7ff5fa0abc49e6f80/bpc-utils-0.10.1.tar.gz"
    sha256 "0954282e947e712152b6396f7b04487c28e2cdfef7e4538453cb13662faa7d33"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/a2/0e/41f0cca4b85a6ea74d66d2226a7cda8e41206a624f5b330b958ef48e2e52/parso-0.8.3.tar.gz"
    sha256 "8c07be290bb59f03588915921e29e8a50002acaf2cdc5fa0e0114f91709fafa0"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/16/3a/0d26ce356c7465a19c9ea8814b960f8a36c3b0d07c323176620b7b483e44/typing_extensions-4.10.0.tar.gz"
    sha256 "b0abd7c89e8fb96f98db18d86106ff1d90ab692004eb746cf6eda2682f91b3cb"
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
