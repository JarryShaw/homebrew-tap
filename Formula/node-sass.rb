class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.54.0.tgz"
  sha256 "e47a1e370f78990f1f6f3047a86f166ea6184f3a4e37193b16df08f9950b555b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7c68a97888aad640d3fb00bc9f41b1d155870d5f06cdfad8f9e1e5b8643a23e6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7c68a97888aad640d3fb00bc9f41b1d155870d5f06cdfad8f9e1e5b8643a23e6"
    sha256 cellar: :any_skip_relocation, monterey:       "7c68a97888aad640d3fb00bc9f41b1d155870d5f06cdfad8f9e1e5b8643a23e6"
    sha256 cellar: :any_skip_relocation, big_sur:        "7c68a97888aad640d3fb00bc9f41b1d155870d5f06cdfad8f9e1e5b8643a23e6"
    sha256 cellar: :any_skip_relocation, catalina:       "7c68a97888aad640d3fb00bc9f41b1d155870d5f06cdfad8f9e1e5b8643a23e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "52cc2831b05ad9829d1889418fc61835623fb0c1ecabc3310bf790bf088d8ca8"
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
