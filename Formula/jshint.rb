require "language/node"

class Jshint < Formula
  desc "Static analysis tool for JavaScript"
  homepage "http://jshint.com/"
  url "https://registry.npmjs.org/jshint/-/jshint-2.13.2.tgz"
  sha256 "8c3d0e6dc4e9552de64738db0440ee93582e3fd75efadd858702272e24e9a533"
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
