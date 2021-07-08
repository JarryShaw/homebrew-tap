require "language/node"

class Appdmg < Formula
  desc "Generate beautiful DMG-images for your OS X applications"
  homepage "https://github.com/LinusU/node-appdmg#readme"
  url "https://registry.npmjs.org/appdmg/-/appdmg-0.6.1.tgz"
  sha256 "aae7b8914f28f9c48c284e05015b997c0998dc9af14f01fdfa8b5acbae7921e9"
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
