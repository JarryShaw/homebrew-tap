class SnootyLextudio < Formula
  include Language::Python::Virtualenv

  desc "Visual Studio Code language server for reStructureText"
  homepage "https://github.com/vscode-restructuredtext/snooty-parser"
  url "https://files.pythonhosted.org/packages/65/4d/3448bc230ca6088b68ea9c5f5ef60d66bd7e8fb7d525fd740a3ffc5ed2dc/snooty-lextudio-1.8.2.dev0.tar.gz#sha256=18de0b78ec32fed13cc0b5c90d39df654f3471eb887d4bc84baaa41c13b5aa55"
  sha256 "18de0b78ec32fed13cc0b5c90d39df654f3471eb887d4bc84baaa41c13b5aa55"

  head "https://github.com/vscode-restructuredtext/snooty-parser.git", branch: "master"

  depends_on "homebrew/core/python"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6c/ae/d26450834f0acc9e3d1f74508da6df1551ceab6c2ce0766a593362d6d57f/certifi-2021.10.8.tar.gz"
    sha256 "78884e7c1d4b00ce3cea67b44566851c4343c120abd683433ce934a68ea58872"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/56/31/7bcaf657fafb3c6db8c787a865434290b726653c912085fbd371e9b92e1c/charset-normalizer-2.0.12.tar.gz"
    sha256 "2857e29ff0d34db842cd7ca3230549d1a697f96ee6d3fb071cfa6c7393832597"
  end

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/57/b1/b880503681ea1b64df05106fc7e3c4e3801736cf63deffc6fa7fc5404cf5/docutils-0.18.1.tar.gz"
    sha256 "679987caf361a7539d76e584cbeddc311e3aee937877c87346f31debc63e9d06"
  end

  resource "fett" do
    url "https://files.pythonhosted.org/packages/a6/fb/d4f8e22ea58cfb4a86f617982f037d3fd057491b50d8f0fe81495c2f6f64/fett-0.3.2.tar.gz"
    sha256 "f06a819ac7caba01f1c84c4b8132671d1d289d17becea7747448e271b05be0a1"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436/idna-3.3.tar.gz"
    sha256 "9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d"
  end

  resource "networkx" do
    url "https://files.pythonhosted.org/packages/3f/5e/5e9ae193c6384bd47aae5bc9bd2c48db7115f483b0ff9fef7d263e3dbb09/networkx-2.8.tar.gz"
    sha256 "4a52cf66aed221955420e11b3e2e05ca44196b4829aab9576d4d439212b0a14f"
  end

  resource "pymongo" do
    url "https://files.pythonhosted.org/packages/19/5c/ef2753159dfb4e5879e2b091412186f66faae01ce8151761617138c28c91/pymongo-4.1.1.tar.gz"
    sha256 "d7b8f25c9b0043cbaf77b8b895814e33e7a3c807a097377c07e1bd49946030d5"
  end

  resource "python-jsonrpc-server" do
    url "https://files.pythonhosted.org/packages/81/7d/c4c4102b94ef2e090d94fc02625653d3d3a0306e53ef24bcb6e9496bfc1e/python-jsonrpc-server-0.4.0.tar.gz"
    sha256 "62c543e541f101ec5b57dc654efc212d2c2e3ea47ff6f54b2e7dcb36ecf20595"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/36/2b/61d51a2c4f25ef062ae3f74576b01638bebad5e045f747ff12643df63844/PyYAML-6.0.tar.gz"
    sha256 "68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/60/f3/26ff3767f099b73e0efa138a9998da67890793bfa475d8278f84a30fec77/requests-2.27.1.tar.gz"
    sha256 "68d7c56fd5a8999887728ef304a6d12edc7be74f1cfa47714fc8b414525c9a61"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/fe/71/1df93bd59163c8084d812d166c907639646e8aac72886d563851b966bf18/typing_extensions-4.2.0.tar.gz"
    sha256 "f1c24655a0da0d1b67f07e17a5e6b2a105894e6824b92096378bb3668ef02376"
  end

  resource "ujson" do
    url "https://files.pythonhosted.org/packages/e4/fc/2dee0e78162aa1ad03dadde9a9b5c281d6f8bb0eed6810a270486d8fc041/ujson-5.2.0.tar.gz"
    sha256 "163191b88842d874e081707d35de2e205e0e396e70fd068d1038879bca8b17ad"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/1b/a5/4eab74853625505725cefdf168f48661b2cd04e7843ab836f3f63abf81da/urllib3-1.26.9.tar.gz"
    sha256 "aabaf16477806a5e1dd19aa41f8c2b7950dd3c746362d7e3223dbe6de6ac448e"
  end

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/b3/d2/a04951838e0b0cea20aff5214109144e6869101818e7f90bf3b68ea2facf/watchdog-2.1.7.tar.gz"
    sha256 "3fd47815353be9c44eebc94cc28fe26b2b0c5bd889dafc4a5a7cbdf924143480"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"snooty", "--help"
  end
end
