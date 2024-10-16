class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.21.2/docutils-0.21.2.tar.gz"
  sha256 "3a6b18732edf182daa3cd12775bbb338cf5691468f91eeeb109deff6ebfa986f"

  option "without-pil", "build without Python Image Library support"
  option "without-pygments", "build without code syntax highlighting support"

  depends_on "homebrew/core/freetype" => :build
  depends_on "homebrew/core/fribidi" => :build
  depends_on "homebrew/core/harfbuzz" => :build
  depends_on "homebrew/core/libjpeg" => :build
  depends_on "homebrew/core/libtiff" => :build
  depends_on "homebrew/core/little-cms2" => :build
  depends_on "homebrew/core/webp" => :build
  depends_on "homebrew/core/python@3.9"

  conflicts_with "homebrew/core/docutils", because: "this is a port of docutils from homebrew-core"

  resource "libraqm" do
    url "https://raw.githubusercontent.com/python-pillow/pillow-depends/master/raqm-cmake-99300ff3.tar.gz"
    sha256 "28702a1618cf11b86fadc5fcad6247c874900898c12b265f6cb79249fc82d428"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/a5/26/0d95c04c868f6bdb0c447e3ee2de5564411845e36a858cfd63766bc7b563/pillow-11.0.0.tar.gz"
    sha256 "72bacbaf24ac003fea9bff9837d1eedb6088758d41e100c1552930151f677739"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/8e/62/8336eff65bcbc8e4cb5d05b55faf041285951b6e80f33e2bff2024788f31/pygments-2.18.0.tar.gz"
    sha256 "786ff802f32e91311bff3889f6e9a86e81505fe99f2735bb6d60ae0c5004f199"
  end

  def install
    # create virtualenv
    venv = virtualenv_create(libexec)

    # install Pygments
    venv.pip_install resource("Pygments") if build.with?("pygments")

    # install PIL
    if build.with?("pil")
      resource("libraqm").stage do
        # c.f. https://github.com/python-pillow/Pillow/blob/master/depends/install_raqm_cmake.sh
        (buildpath/"install_raqm_cmake.sh").atomic_write <<~EOS
          pushd $archive

          mkdir build
          cd build
          cmake ..
          make && sudo make install
          cd ..

          popd
        EOS

        system buildpath/"install_raqm_cmake.sh"
      end

      venv.pip_install resource("Pillow")
    end

    # link files
    venv.pip_install_and_link buildpath
  end

  test do
    system "#{bin}/rst2man.py", "#{prefix}/HISTORY.txt"
  end
end
