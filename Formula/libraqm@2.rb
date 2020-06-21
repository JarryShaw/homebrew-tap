class LibraqmAT2 < Formula
  desc "Library for complex text layout"
  homepage "https://github.com/HOST-Oman/libraqm"
  url "https://github.com/HOST-Oman/libraqm/archive//v0.2.0.tar.gz"
  sha256 "a12a8428e18b4e35b4984a8f5afc225c8ec0ca7aeb64455a47671316c3e29cdb"

  depends_on "homebrew/core/freetype"
  depends_on "homebrew/core/fribidi"
  depends_on "homebrew/core/harfbuzz"
  depends_on "homebrew/core/autoconf" => :build
  depends_on "homebrew/core/automake" => :build
  depends_on "homebrew/core/gtk-doc" => :build
  depends_on "homebrew/core/libtool" => :build
  depends_on "homebrew/core/pkg-config" => :build

  def install
    ENV["LIBTOOL"] = Formula["libtool"].bin
    ENV["PKG_CONFIG"] = Formula["pkg-config"].bin/"pkg-config"

    ENV["HARFBUZZ_CFLAGS"] = "-I#{Formula["harfbuzz"].include/"harfbuzz"}"
    ENV["HARFBUZZ_LIBS"] = Formula["harfbuzz"].lib

    # for the docs
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--enable-gtk-doc"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <raqm.h>

      int main() {
        return 0;
      }
    EOS

    system ENV.cc, "test.c",
                   "-I#{include}",
                   "-I#{Formula["freetype"].include/"freetype2"}",
                   "-o", "test"
    system "./test"
  end
end
