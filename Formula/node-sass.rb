class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.54.8.tgz"
  sha256 "3a96a7b8101274cde4281f8132e7912d197dd2ff347036f0492e604536fe5c30"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f39d7dd6af57acaf99293fa1632181e4c3037adba05287c8df9b5d7bea06340b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f39d7dd6af57acaf99293fa1632181e4c3037adba05287c8df9b5d7bea06340b"
    sha256 cellar: :any_skip_relocation, monterey:       "f39d7dd6af57acaf99293fa1632181e4c3037adba05287c8df9b5d7bea06340b"
    sha256 cellar: :any_skip_relocation, big_sur:        "f39d7dd6af57acaf99293fa1632181e4c3037adba05287c8df9b5d7bea06340b"
    sha256 cellar: :any_skip_relocation, catalina:       "f39d7dd6af57acaf99293fa1632181e4c3037adba05287c8df9b5d7bea06340b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c314bfce533d004141ee580902dcde3ac2e96c475853d3099056b3e8b0fb9e17"
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
