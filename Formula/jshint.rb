require "language/node"

class Jshint < Formula
  desc "Static analysis tool for JavaScript"
  homepage "http://jshint.com/"
  url "https://registry.npmjs.org/jshint/-/jshint-2.12.0.tgz"
  sha256 "82a255d6580c17682f35da20bfa424299b3f9d7c734f02e97a0a32e8e1242f69"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system bin/"jshint", "--help"
  end
end
