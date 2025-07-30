class Walrus < Formula
  include Language::Python::Virtualenv

  desc "Backport compiler for Python 3.8 assignment expressions"
  homepage "https://github.com/pybpc/walrus#walrus"
  url "https://github.com/pybpc/walrus/archive/v0.1.5.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  head "https://github.com/pybpc/walrus.git", branch: "master"

  depends_on "homebrew/core/python@3.9"

  resource "bpc-utils" do
    url "https://files.pythonhosted.org/packages/c8/b7/8131c9884d2d79c5b68d6ad8856aa7e7d89543a4dda7ff5fa0abc49e6f80/bpc-utils-0.10.1.tar.gz"
    sha256 "0954282e947e712152b6396f7b04487c28e2cdfef7e4538453cb13662faa7d33"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/66/94/68e2e17afaa9169cf6412ab0f28623903be73d1b32e208d9e8e541bb086d/parso-0.8.4.tar.gz"
    sha256 "eb3a7b58240fb99099a345571deecc0f9540ea5f4dd2fe14c2a99d6b281ab92d"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/98/5a/da40306b885cc8c09109dc2e1abd358d5684b1425678151cdaed4731c822/typing_extensions-4.14.1.tar.gz"
    sha256 "38b39f4aeeab64884ce9f74c94263ef78f3c22467c8724005483154c26648d36"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/66/94/68e2e17afaa9169cf6412ab0f28623903be73d1b32e208d9e8e541bb086d/parso-0.8.4.tar.gz"
    sha256 "eb3a7b58240fb99099a345571deecc0f9540ea5f4dd2fe14c2a99d6b281ab92d"
  end

  resource "tbtrim" do
    url "https://files.pythonhosted.org/packages/85/62/89756f5d2d61691591c4293fd4cc1fbb3aab1466251c7319fe60dd08fb27/tbtrim-0.3.1.tar.gz"
    sha256 "b6285ac02e9a7b78fab97de65668fe2def0f5d8783b0e0dfcb4b7c0a635b3d11"
  end

  def install
    virtualenv_install_with_resources

    man1.install "share/walrus.1"
    bash_completion.install "share/walrus.bash-completion"
  end

  test do
    (testpath/"test.py").write <<~EOS
      a = (b := 1)
      print(a, b)
    EOS

    std_output = <<~EOS
      1 1
    EOS

    system bin/"walrus", "--no-archive", "test.py"
    assert_match std_output, shell_output("#{Formula["python3"].bin}/python test.py")
  end
end
