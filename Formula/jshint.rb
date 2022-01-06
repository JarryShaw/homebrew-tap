require "language/node"

class Jshint < Formula
  desc "Static analysis tool for JavaScript"
  homepage "http://jshint.com/"
  url "https://registry.npmjs.org/jshint/-/jshint-2.13.3.tgz"
  sha256 "b6e9897134aac532cae572615ff091d4cc643f5f3711bc71dd88054cda005795"
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
