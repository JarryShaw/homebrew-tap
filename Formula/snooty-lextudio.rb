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
    url "https://files.pythonhosted.org/packages/68/e4/e014e7360fc6d1ccc507fe0b563b4646d00e0d4f9beec4975026dd15850b/charset-normalizer-2.0.9.tar.gz"
    sha256 "b0b883e8e874edfdece9c28f314e3dd5badf067342e42fb162203335ae61aa2c"
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
    url "https://files.pythonhosted.org/packages/97/ae/7497bc5e1c84af95e585e3f98585c9f06c627fac6340984c4243053e8f44/networkx-2.6.3.tar.gz"
    sha256 "c0946ed31d71f1b732b5aaa6da5a0388a345019af232ce2f49c766e2d6795c51"
  end

  resource "pymongo" do
    url "https://files.pythonhosted.org/packages/3f/ff/7ec17064d403799d644f7db9c2e99202441849aebe771efe3199f3dd9076/pymongo-4.0.1.tar.gz"
    sha256 "13d0624c13a91da71fa0d960205d93b3d98344481be865ee7cc238c972d41d73"
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
    url "https://files.pythonhosted.org/packages/c0/e3/826e27b942352a74b656e8f58b4dc7ed9495ce2d4eeb498181167c615303/requests-2.27.0.tar.gz"
    sha256 "8e5643905bf20a308e25e4c1dd379117c09000bf8a82ebccc462cfb1b34a16b5"
  end

  resource "toml" do
    url "https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c/toml-0.10.2.tar.gz"
    sha256 "b3bda1d108d5dd99f4a20d24d9c348e91c4db7ab1b749200bded2f839ccbe68f"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/0d/4a/60ba3706797b878016f16edc5fbaf1e222109e38d0fa4d7d9312cb53f8dd/typing_extensions-4.0.1.tar.gz"
    sha256 "4ca091dea149f945ec56afb48dae714f21e8692ef22a395223bcd328961b6a0e"
  end

  resource "ujson" do
    url "https://files.pythonhosted.org/packages/92/4a/2676677f59709517560b2b7eeb027453e86643d54d04687602e76cca4380/ujson-5.1.0.tar.gz"
    sha256 "a88944d2f99db71a3ca0c63d81f37e55b660edde0b07216fb65a3e46403ef004"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/80/be/3ee43b6c5757cabea19e75b8f46eaf05a2f5144107d7db48c7cf3a864f73/urllib3-1.26.7.tar.gz"
    sha256 "4987c65554f7a2dbf30c18fd48778ef124af6fab771a377103da0585e2336ece"
  end

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/e8/a8/fc4edd7d768361b00ea850e5310211d157df6b5a1db6148dd434e787d898/watchdog-2.1.6.tar.gz"
    sha256 "a36e75df6c767cbf46f61a91c70b3ba71811dfa0aca4a324d9407a06a8b7a2e7"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"snooty", "--help"
  end
end
