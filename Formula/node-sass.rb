class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.26.8.tgz"
  sha256 "aaf64c25a0efdd231fab1c98b2de31fe0a4b163444383e656077c12412f6736d"

  bottle do
    cellar :any_skip_relocation
    sha256 "ba7800da4be81a8cceec16a5f66fbaffdb03c617e8c9ca04e2aea15936d758d1" => :catalina
    sha256 "3c50b59bc795fca22290b62f0bbf2f2b85b89ae9ce7e80bd9aa6d011b97a6610" => :mojave
    sha256 "d4388fee525f8dd257cef3b813c7c705281364f8249f60a66cab4f8a46b22cdd" => :high_sierra
  end

  depends_on "homebrew/core/node"
  conflicts_with "homebrew/core/node-sass", :because => "it is now integrated with homebrew-core"
  conflicts_with "jarryshaw/tap/dart-sass", :because => "both install a `sass` binary"
  # waiting for pull request at #47438
  # conflicts_with "dart-sass", :because => "both install a `sass` binary"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.scss").write <<~EOS
      div {
        img {
          border: 0px;
        }
      }
    EOS

    assert_equal "div img{border:0px}",
    shell_output("#{bin}/sass --style=compressed test.scss").strip
  end
end
