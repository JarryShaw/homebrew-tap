require "language/node"

class Jshint < Formula
  desc "Static analysis tool for JavaScript"
  homepage "http://jshint.com/"
  url "https://registry.npmjs.org/jshint/-/jshint-2.13.5.tgz"
  sha256 "fa122e1b4eacbe5658596748c710d2cfec548aab8b8286960fc9effb3914944e"
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
