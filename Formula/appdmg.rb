require "language/node"

class Appdmg < Formula
  desc "Generate beautiful DMG-images for your OS X applications"
  homepage "https://github.com/LinusU/node-appdmg#readme"
  url "https://registry.npmjs.org/appdmg/-/appdmg-0.6.4.tgz"
  sha256 "1386cc525c253c28d7ab9609fb284ecfdb652c2bc632f6d674b8069163efcb66"
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
