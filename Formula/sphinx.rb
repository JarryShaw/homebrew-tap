class Sphinx < Formula
  include Language::Python::Virtualenv

  desc "Tool to create intelligent and beautiful documentation"
  homepage "https://www.sphinx-doc.org/"
  url "https://github.com/sphinx-doc/sphinx/archive/v7.3.7.tar.gz"
  sha256 "43c4cdb796b41dc1645117efbc74655d41ccea49fe34170a2b5bb88eee6f83a5"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7186d6921a44384f9f45dfcd9548e2b0fd31f8c4716c30ce4fff3e12fc1bbcea"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "28fffa95a0b3c9bc0eac0e88da131967c8777f4ec49164700ba488f0f367d405"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ba9e4d6794480bb97281cc671cd709d5468d452c5f21fee507fdeacc882a8a5e"
    sha256 cellar: :any_skip_relocation, sonoma:         "645bcf66dfe4323d1c4bd1bf67eabee978d6033562c18aef39271ec326bd6f07"
    sha256 cellar: :any_skip_relocation, ventura:        "45fd6b2f0a86d8a16b291dc2ee9809df92a2ea0ef8b74999a3fd8fd8e905d8bc"
    sha256 cellar: :any_skip_relocation, monterey:       "b8029904c4c447a7134ad8c1c5f36408a983a5b3b6f2c0ae40d822ad414aedc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f473bb1f49a141c993e7d7bc8b0c7a836e9f66711c5055913bdf3fbb73927c8d"
  end

  depends_on "homebrew/core/python@3.9"

  conflicts_with "homebrew/core/sphinx-doc", because: "this is a port of sphinx-doc from homebrew-core"

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/ed/55/39036716d19cab0747a5020fc7e907f362fbf48c984b14e62127f7e68e5d/jinja2-3.1.4.tar.gz"
    sha256 "4a3aee7acbbe7303aede8e9648d13b8bf88a429282aa6122a993f0ac800cb369"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/87/5b/aae44c6655f3801e81aa3eef09dbbf012431987ba564d7231722f68df02d/MarkupSafe-2.1.5.tar.gz"
    sha256 "d283d37a890ba4c1ae73ffadf8046435c76e7bc2247bbb63c00bd1a709c6544b"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/8e/62/8336eff65bcbc8e4cb5d05b55faf041285951b6e80f33e2bff2024788f31/pygments-2.18.0.tar.gz"
    sha256 "786ff802f32e91311bff3889f6e9a86e81505fe99f2735bb6d60ae0c5004f199"
  end

  resource "alabaster" do
    url "https://files.pythonhosted.org/packages/c9/3e/13dd8e5ed9094e734ac430b5d0eb4f2bb001708a8b7856cbf8e084e001ba/alabaster-0.7.16.tar.gz"
    sha256 "75a8b99c28a5dad50dd7f8ccdd447a121ddb3892da9e53d1ca5cca3106d58d65"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/e6/e3/c4c8d473d6780ef1853d630d581f70d655b4f8d7553c6997958c283039a2/anyio-4.4.0.tar.gz"
    sha256 "5aadc6a1bbb7cdb0bede386cac5e2940f5e2ff3aa20277e991cf028e0585ce94"
  end

  resource "Babel" do
    url "https://files.pythonhosted.org/packages/15/d2/9671b93d623300f0aef82cde40e25357f11330bdde91743891b22a555bed/babel-2.15.0.tar.gz"
    sha256 "8daf0e265d05768bc6c7a314cf1321e9a123afc328cc635c18622a2f30a04413"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/07/b3/e02f4f397c81077ffc52a538e0aec464016f1860c472ed33bd2a1d220cc5/certifi-2024.6.2.tar.gz"
    sha256 "3cd43f1c6fa7dedc5899d69d3ad0398fd018ad1a17fba83ddaf78aa46c747516"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/ae/ed/aefcc8cd0ba62a0560c3c18c33925362d46c6075480bfa4df87b28e169a9/docutils-0.21.2.tar.gz"
    sha256 "3a6b18732edf182daa3cd12775bbb338cf5691468f91eeeb109deff6ebfa986f"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/f5/38/3af3d3633a34a3316095b39c8e8fb4853a28a536e55d347bd8d8e9a14b03/h11-0.14.0.tar.gz"
    sha256 "8f19fbbe99e72420ff35c00b27a34cb9937e902a8b810e2c88300c6f0a3b699d"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/21/ed/f86a79a07470cb07819390452f178b3bef1d375f2ec021ecfc709fc7cf07/idna-3.7.tar.gz"
    sha256 "028ff3aadf0609c1fd278d8ea3089299412a7a8b9bd005dd08b9f8285bcb5cfc"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/a7/84/62473fb57d61e31fef6e36d64a179c8781605429fd927b5dd608c997be31/imagesize-1.4.1.tar.gz"
    sha256 "69150444affb9cb0d5cc5a92b3676f0b2fb7cd9ae39e947a5e11a36b4497cd4a"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/51/65/50db4dda066951078f0a96cf12f4b9ada6e4b811516bf0262c0f4f7064d4/packaging-24.1.tar.gz"
    sha256 "026ed72c8ed3fcce5bf8950572258698927fd1dbda10a5e981cdf0ac37f4f002"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896afe06353c2a2913/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "sniffio" do
    url "https://files.pythonhosted.org/packages/a2/87/a6771e1546d97e7e041b6ae58d80074f81b7d5121207425c964ddf5cfdbd/sniffio-1.3.1.tar.gz"
    sha256 "f4324edc670a0f49750a81b895f35c3adb843cca46f0530f79fc1babb23789dc"
  end

  resource "snowballstemmer" do
    url "https://files.pythonhosted.org/packages/44/7b/af302bebf22c749c56c9c3e8ae13190b5b5db37a33d9068652e8f73b7089/snowballstemmer-2.2.0.tar.gz"
    sha256 "09b16deb8547d3412ad7b590689584cd0fe25ec8db3be37788be3810cbf19cb1"
  end

  resource "Sphinx" do
    url "https://files.pythonhosted.org/packages/b7/0a/b88033900b1582f5ed8f880263363daef968d1cd064175e32abfd9714410/sphinx-7.3.7.tar.gz"
    sha256 "a4a7db75ed37531c05002d56ed6948d4c42f473a36f46e1382b0bd76ca9627bc"
  end

  resource "sphinx-autobuild" do
    url "https://files.pythonhosted.org/packages/d2/bc/8016eee9ffb86069ae7e658c136bad31a9854b476a212492b5aab4d4d5f6/sphinx_autobuild-2024.4.16.tar.gz"
    sha256 "1c0ed37a1970eed197f9c5a66d65759e7c4e4cba7b5a5d77940752bf1a59f2c7"
  end

  resource "sphinxcontrib-applehelp" do
    url "https://files.pythonhosted.org/packages/26/6b/68f470fc337ed24043fec987b101f25b35010970bd958970c2ae5990859f/sphinxcontrib_applehelp-1.0.8.tar.gz"
    sha256 "c40a4f96f3776c4393d933412053962fac2b84f4c99a7982ba42e09576a70619"
  end

  resource "sphinxcontrib-devhelp" do
    url "https://files.pythonhosted.org/packages/c7/a1/80b7e9f677abc673cb9320bf255ad4e08931ccbc2e66bde4b59bad3809ad/sphinxcontrib_devhelp-1.0.6.tar.gz"
    sha256 "9893fd3f90506bc4b97bdb977ceb8fbd823989f4316b28c3841ec128544372d3"
  end

  resource "sphinxcontrib-htmlhelp" do
    url "https://files.pythonhosted.org/packages/8a/03/2f9d699fbfdf03ecb3b6d0e2a268a8998d009f2a9f699c2dcc936899257d/sphinxcontrib_htmlhelp-2.0.5.tar.gz"
    sha256 "0dc87637d5de53dd5eec3a6a01753b1ccf99494bd756aafecd74b4fa9e729015"
  end

  resource "sphinxcontrib-jsmath" do
    url "https://files.pythonhosted.org/packages/b2/e8/9ed3830aeed71f17c026a07a5097edcf44b692850ef215b161b8ad875729/sphinxcontrib-jsmath-1.0.1.tar.gz"
    sha256 "a9925e4a4587247ed2191a22df5f6970656cb8ca2bd6284309578f2153e0c4b8"
  end

  resource "sphinxcontrib-qthelp" do
    url "https://files.pythonhosted.org/packages/ac/29/705cd4e93e98a8473d62b5c32288e6de3f0c9660d3c97d4e80d3dbbad82b/sphinxcontrib_qthelp-1.0.7.tar.gz"
    sha256 "053dedc38823a80a7209a80860b16b722e9e0209e32fea98c90e4e6624588ed6"
  end

  resource "sphinxcontrib-serializinghtml" do
    url "https://files.pythonhosted.org/packages/54/13/8dd7a7ed9c58e16e20c7f4ce8e4cb6943eb580955236d0c0d00079a73c49/sphinxcontrib_serializinghtml-1.1.10.tar.gz"
    sha256 "93f3f5dc458b91b192fe10c397e324f262cf163d79f3282c158e8436a2c4511f"
  end

  resource "starlette" do
    url "https://files.pythonhosted.org/packages/61/b5/6bceb93ff20bd7ca36e6f7c540581abb18f53130fabb30ba526e26fd819b/starlette-0.37.2.tar.gz"
    sha256 "9af890290133b79fc3db55474ade20f6220a364a0402e0b556e7cd5e1e093823"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/43/6d/fa469ae21497ddc8bc93e5877702dca7cb8f911e337aca7452b5724f1bb6/urllib3-2.2.2.tar.gz"
    sha256 "dd505485549a7a552833da5e6063639d0d177c04f23bc3864e41e5dc5f612168"
  end

  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/37/16/9f5ccaa1a76e5bfbaa0c67640e2db8a5214ca08d92a1b427fa1677b3da88/uvicorn-0.30.1.tar.gz"
    sha256 "d46cd8e0fd80240baffbcd9ec1012a712938754afcf81bce56c024c1656aece8"
  end

  resource "watchfiles" do
    url "https://files.pythonhosted.org/packages/53/e1/666771f0746f95c4df767ff98ff17fe55bb0c32ac88ec14ce0615a789330/watchfiles-0.22.0.tar.gz"
    sha256 "988e981aaab4f3955209e7e28c7794acdb690be1efa7f16f8ea5aba7ffdadacb"
  end

  resource "websockets" do
    url "https://files.pythonhosted.org/packages/2e/62/7a7874b7285413c954a4cca3c11fd851f11b2fe5b4ae2d9bee4f6d9bdb10/websockets-12.0.tar.gz"
    sha256 "81df9cbcbb6c260de1e007e58c011bfebe2dafc8435107b0537f393dd38c8b1b"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"sphinx-quickstart", "-pProject", "-aAuthor", "-v1.0", "-q", testpath
    system bin/"sphinx-build", testpath, testpath/"build"
    assert_predicate testpath/"build/index.html", :exist?
  end
end
