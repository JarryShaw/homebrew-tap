require "language/node"

class Appdmg < Formula
  desc "Generate beautiful DMG-images for your OS X applications"
  homepage "https://github.com/LinusU/node-appdmg#readme"
  url "https://registry.npmjs.org/appdmg/-/appdmg-0.6.6.tgz"
  sha256 "98da7364866e02f603da27e92ab4a40990eb71f90422d0e6e8ba3b08960a3c68"
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
