class Docutils < Formula
  include Language::Python::Virtualenv

  desc "Text processing system for reStructuredText"
  homepage "https://docutils.sourceforge.io"
  url "https://downloads.sourceforge.net/project/docutils/docutils/0.16/docutils-0.16.tar.gz"
  sha256 "7d4e999cca74a52611773a42912088078363a30912e8822f7a3d38043b767573"

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
    url "https://files.pythonhosted.org/packages/73/59/3192bb3bc554ccbd678bdb32993928cb566dccf32f65dac65ac7e89eb311/Pillow-8.1.0.tar.gz"
    sha256 "887668e792b7edbfb1d3c9d8b5d8c859269a0f0eba4dda562adb95500f60dbba"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/29/60/8ff9dcb5eac7f4da327ba9ecb74e1ad783b2d32423c06ef599e48c79b1e1/Pygments-2.7.3.tar.gz"
    sha256 "ccf3acacf3782cbed4a989426012f1c535c9a90d3a7fc3f16d231b9372d2b716"
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
