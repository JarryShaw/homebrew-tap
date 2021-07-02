class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.17.1/docutils-0.17.1.tar.gz"
  sha256 "686577d2e4c32380bb50cbb22f575ed742d58168cee37e99117a854bcd88f125"

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

  resource "Pillow" do
    url "https://files.pythonhosted.org/packages/dc/c2/72349bb3a995fda8f4a064ee5dc92903b21886f27be4f5f1ed8c7b7174e4/Pillow-8.3.0.tar.gz"
    sha256 "803606e206f3e366eea46b1e7ab4dac74cfac770d04de9c35319814e11e47c46"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/ba/6e/7a7c13c21d8a4a7f82ccbfe257a045890d4dbf18c023f985f565f97393e3/Pygments-2.9.0.tar.gz"
    sha256 "a18f47b506a429f6f4b9df81bb02beab9ca21d0a5fee38ed15aef65f0545519f"
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
