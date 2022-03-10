class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.49.9.tgz"
  sha256 "fec32b43997766496b70d55f08185586ef2d588235fbe722b9ad82907407010f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a1fe07627ed90c1fa7384734cf8959438949092223958eeee61171d8f4af9fd0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a1fe07627ed90c1fa7384734cf8959438949092223958eeee61171d8f4af9fd0"
    sha256 cellar: :any_skip_relocation, monterey:       "a1fe07627ed90c1fa7384734cf8959438949092223958eeee61171d8f4af9fd0"
    sha256 cellar: :any_skip_relocation, big_sur:        "a1fe07627ed90c1fa7384734cf8959438949092223958eeee61171d8f4af9fd0"
    sha256 cellar: :any_skip_relocation, catalina:       "a1fe07627ed90c1fa7384734cf8959438949092223958eeee61171d8f4af9fd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8a6fec1c4b01440564a519bc1112c3fdae5510f7638f092e892dd409afeac7ee"
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
