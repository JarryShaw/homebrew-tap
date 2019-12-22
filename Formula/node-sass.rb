class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.24.0.tgz"
  sha256 "307b4f7abd346d0d1590ebc3ad655c41ee9f7cc5b42ab0b5cc5dfb0259ecca1c"

  depends_on "node"

  conflicts_with "node-sass", :because => "it is now integrated with homebrew-core"
  conflicts_with "jarryshaw/tap/dart-sass", :because => "both install a `sass` binary"

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
