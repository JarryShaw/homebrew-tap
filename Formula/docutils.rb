class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.14/docutils-0.14.tar.gz"
  sha256 "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "71bc62531fd234add02633a69b12c2f1f43d6799d5ab1615ab6c9b22064803cc" => :mojave
    sha256 "5f317d1324dd57a4053c3feb518463ed6e67e13589f94f5738a528d63daa6770" => :high_sierra
    sha256 "a91be71816c677dac34fe253695440bebaf54d634652622ca1e797f5cebecbee" => :sierra
  end

  depends_on "python@2"

  option "without-lxml", "build without XML processing support"
  option "without-pillow", "build without Python Image Library support"
  option "without-pygments", "build without code syntax highlighting support"

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/4b/20/ddf5eb3bd5c57582d2b4652b4bbcf8da301bdfe5d805cb94e805f4d7464d/lxml-4.2.5.tar.gz"
    sha256 "36720698c29e7a9626a0dc802ef8885f8f0239bfd1689628ecd459a061f2807f"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/64/69/413708eaf3a64a6abb8972644e0f20891a55e621c6759e2c3f3891e05d63/Pygments-2.3.1.tar.gz"
    sha256 "5ffada19f6203563680669ee7f53b64dabbeb100eb51b61996085e99c03b284a"
  end

  def install
    # create virtualenv
    venv = virtualenv_create(libexec)

    # install lxml
    if build.with?("lxml")
      venv.pip_install resource("lxml")
    end

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
