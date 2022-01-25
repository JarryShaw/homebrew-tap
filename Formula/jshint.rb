require "language/node"

class Jshint < Formula
  desc "Static analysis tool for JavaScript"
  homepage "http://jshint.com/"
  url "https://registry.npmjs.org/jshint/-/jshint-2.13.4.tgz"
  sha256 "1290b3d1b34f4c317b962a014441a2a406e7f3be1f6ddfad31bf8465f3e31293"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"jshint", "--help"
  end
end
