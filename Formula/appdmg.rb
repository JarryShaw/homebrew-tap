require "language/node"

class Appdmg < Formula
  desc "Generate beautiful DMG-images for your OS X applications"
  homepage "https://github.com/LinusU/node-appdmg#readme"
  url "https://registry.npmjs.org/appdmg/-/appdmg-0.6.2.tgz"
  sha256 "518cc2861de257c12f61b7c4a7e9420ac1c032d5934ba1beadf60f0b5074e4bd"
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
    system bin/"appdmg", "--help"
  end
end
