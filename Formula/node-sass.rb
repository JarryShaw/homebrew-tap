class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.49.0.tgz"
  sha256 "01d4b70c06a89ecaf72cade3b4ace94be2c147612946b712de5dee199e77579f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e21bd2f2d6f06257700a7b007a5fc2ed1893962e6e3dcbb60ef9813be2dc3455"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e21bd2f2d6f06257700a7b007a5fc2ed1893962e6e3dcbb60ef9813be2dc3455"
    sha256 cellar: :any_skip_relocation, monterey:       "e21bd2f2d6f06257700a7b007a5fc2ed1893962e6e3dcbb60ef9813be2dc3455"
    sha256 cellar: :any_skip_relocation, big_sur:        "e21bd2f2d6f06257700a7b007a5fc2ed1893962e6e3dcbb60ef9813be2dc3455"
    sha256 cellar: :any_skip_relocation, catalina:       "e21bd2f2d6f06257700a7b007a5fc2ed1893962e6e3dcbb60ef9813be2dc3455"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a793f526f7e2a2feb8d7b9aa2c83f0d2428096b4bf85a56d1d2046e5a826a9d"
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
