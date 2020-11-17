require "language/node"

class Appdmg < Formula
  desc "Generate beautiful DMG-images for your OS X applications"
  homepage "https://github.com/LinusU/node-appdmg#readme"
  url "https://registry.npmjs.org/appdmg/-/appdmg-0.6.0.tgz"
  sha256 "a1faebdec4ed269a9ed159e45634df6abac5fe734970f592ca2c9d649710f48c"
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
