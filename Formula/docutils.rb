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
    url "https://files.pythonhosted.org/packages/7d/2a/2fc11b54e2742db06297f7fa7f420a0e3069fdcf0e4b57dfec33f0b08622/Pillow-8.4.0.tar.gz"
    sha256 "b8e2f83c56e141920c39464b852de3719dfbfb6e3c99a2d8da0edf4fb33176ed"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/15/53/5345177cafa79a49e02c27102019a01ef1682ab170d2138deca47a4c8924/Pygments-2.11.1.tar.gz"
    sha256 "59b895e326f0fb0d733fd28c6839bd18ad0687ba20efc26d4277fd1d30b971f4"
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
