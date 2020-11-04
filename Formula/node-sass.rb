class NodeSass < Formula
  require "language/node"

  desc "JavaScript implementation of a Sass compiler"
  homepage "https://github.com/sass/dart-sass"
  url "https://registry.npmjs.org/sass/-/sass-1.27.0.tgz"
  sha256 "40ffe0c5ebd4f41d814d323f29f3eea5f6bde877ae52a7017a23b740ad096347"
  license "MIT"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "ad140d92f71475bacfe5d9c3534726f4a3f7f098ddd466194fad103266a4f098" => :catalina
    sha256 "22a74ac2c219b4dd2dcf87d39fdc107f4ad7d4735d198ab1446fe465a64a49a9" => :mojave
    sha256 "53ba77b03fd6278da929312c431cc47a8f1fa4c92cbd24cc60704c90d7367bdc" => :high_sierra
  end

  depends_on "homebrew/core/node"

  conflicts_with "homebrew/core/node-sass", because: "it is now integrated with homebrew-core"
  conflicts_with "jarryshaw/tap/dart-sass", because: "both install a `sass` binary"

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
