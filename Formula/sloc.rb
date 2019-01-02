require "language/node"

class Sloc < Formula
  desc "sloc is a simple tool to count SLOC (source lines of code)"
  homepage "https://github.com/flosse/sloc#readme"
  url "https://registry.npmjs.org/sloc/-/sloc-0.2.1.tgz"
  version "0.2.1"
  sha256 "fb56f1763b7dadfd0566f819665efc0725ba8dfbec13c75da3839edf309596e6"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "sloc", "--help"
  end
end
