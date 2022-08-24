class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.54.5.tgz"
  sha256 "b772ef2acccd3325a847bd4efb1020ae6b4ba92433b1e57171e13c95f72dee9a"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c7a29f887aeff0549010ccf091e698ef8020ace1dff272c905f4f9516a3e642f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c7a29f887aeff0549010ccf091e698ef8020ace1dff272c905f4f9516a3e642f"
    sha256 cellar: :any_skip_relocation, monterey:       "c7a29f887aeff0549010ccf091e698ef8020ace1dff272c905f4f9516a3e642f"
    sha256 cellar: :any_skip_relocation, big_sur:        "c7a29f887aeff0549010ccf091e698ef8020ace1dff272c905f4f9516a3e642f"
    sha256 cellar: :any_skip_relocation, catalina:       "c7a29f887aeff0549010ccf091e698ef8020ace1dff272c905f4f9516a3e642f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ca6801566764b516b31d4814e581c1a8157530071676e2c4a174fe0f875abf4"
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
