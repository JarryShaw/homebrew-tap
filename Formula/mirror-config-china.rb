require "language/node"

class MirrorConfigChina < Formula
  desc "Mirrors in China about node.js"
  homepage "https://github.com/gucong3000/mirror-config-china#readme"
  url "https://registry.npmjs.org/mirror-config-china/-/mirror-config-china-2.5.1.tgz"
  sha256 "e0bb9c612ab4e3ce40c4137e88f1cb70660d376d56ad32ae1fabb4d25fa1741e"
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
    system bin/"mirror-config-china", "--registry=https://registry.npm.taobao.org"
  end
end
