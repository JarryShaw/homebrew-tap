class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.45.0.tgz"
  sha256 "f92c73c44f14fe29458547ce39a61c3d5d4f75856e4bf7509a4dfd0fe6313c2d"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d7867df7db2a8aa75b9de6da47fe1883ab6af83f029cb5eebd11943c10452730"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d7867df7db2a8aa75b9de6da47fe1883ab6af83f029cb5eebd11943c10452730"
    sha256 cellar: :any_skip_relocation, monterey:       "d7867df7db2a8aa75b9de6da47fe1883ab6af83f029cb5eebd11943c10452730"
    sha256 cellar: :any_skip_relocation, big_sur:        "d7867df7db2a8aa75b9de6da47fe1883ab6af83f029cb5eebd11943c10452730"
    sha256 cellar: :any_skip_relocation, catalina:       "d7867df7db2a8aa75b9de6da47fe1883ab6af83f029cb5eebd11943c10452730"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "254ae58fe8130ed77f412e9e759f283026d183f2d1afc45b4343402d29c01356"
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
