class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.16/docutils-0.16.tar.gz"
  sha256 "7d4e999cca74a52611773a42912088078363a30912e8822f7a3d38043b767573"

  option "without-pil", "build without Python Image Library support"
  option "without-pygments", "build without code syntax highlighting support"

  depends_on "python"

  conflicts_with "docutils", :because => "this is a port of docutils from homebrew-core"

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/cb/9f/27d4844ac5bf158a33900dbad7985951e2910397998e85712da03ce125f0/Pygments-2.5.2.tar.gz"
    sha256 "98c8aa5a9f778fcd1026a17361ddaf7330d1b7c62ae97c3bb0ae73e0b9b6b0fe"
  end

  def install
    # create virtualenv
    venv = virtualenv_create(libexec)

    # install Pygments
    if build.with?("pygments")
      venv.pip_install resource("Pygments")
    end

    # link files
    venv.pip_install_and_link buildpath

    # install Pillow afterwards
    if build.with?("pillow")
      system libexec/"bin/pip", "install", "Pillow"
    end
  end

  test do
    system "#{bin}/rst2man.py", "#{prefix}/HISTORY.txt"
  end
end
