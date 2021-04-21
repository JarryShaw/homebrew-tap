class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.32.10.tgz"
  sha256 "28a55fb73313df27f0f48cece8a4cb795ce471439b701dbac61d34b47e8f2c09"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dca45ec84ded721fc6ea1e3b8c229794926af43a6cd6f235ef3137b4ce0f8bc4"
    sha256 cellar: :any_skip_relocation, big_sur:       "f6754640f58de86e4c4ba4cb0371a2fd89dc582e8758fbecddb6cdcf24db3dbb"
    sha256 cellar: :any_skip_relocation, catalina:      "f6754640f58de86e4c4ba4cb0371a2fd89dc582e8758fbecddb6cdcf24db3dbb"
    sha256 cellar: :any_skip_relocation, mojave:        "d4b4afa68e4ded344d28e377457a69f3de8be9277a2d938f9c5e13f22fe50c2c"
  end

  depends_on "homebrew/core/node"

  conflicts_with "homebrew/core/node-sass", because: "it is now integrated with homebrew-core"
  conflicts_with "jarryshaw/tap/dart-sass", because: "both install a `sass` binary"

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
