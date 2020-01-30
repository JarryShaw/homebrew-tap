class Sphinx < Formula
  include Language::Python::Virtualenv

  desc "Tool to create intelligent and beautiful documentation"
  homepage "https://www.sphinx-doc.org/"
  url "https://github.com/sphinx-doc/sphinx/archive/v2.3.1.tar.gz"
  sha256 "5baff07fff9b486aab6f955792355b58ebc3a293b0451a31dc860e9cced2ca8f"

  bottle do
    cellar :any_skip_relocation
    sha256 "60c37affa28c278d7c5bf331e46b330279b24eb18c5574f51d7f5286d6490376" => :catalina
    sha256 "94b3f25034f62f1ad3d39d81c823e581d2fbfb3af13b74a8cb92f95713b146ae" => :mojave
    sha256 "c8675c458d5d90a910a181b8cc53e0800285c8677831f8ee2dba4b6b811da20a" => :high_sierra
  end

  depends_on "python"

  conflicts_with "sphinx-doc", :because => "this is a port of sphinx-doc from homebrew-core"

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/30/4b/898001ad08a1c51ffdcfadb028e5654a78484d0a3669d72d56f6ae5472bb/Jinja2-2.11.0.tar.gz"
    sha256 "d6609ae5ec3d56212ca7d802eda654eaf2310000816ce815361041465b108be4"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz"
    sha256 "29872e92839765e546828bb7754a68c418d927cd064fd4708fab9fe9c8bb116b"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/3d/d9/ea9816aea31beeadccd03f1f8b625ecf8f645bd66744484d162d84803ce5/PyYAML-5.3.tar.gz"
    sha256 "e9f45bd5b92c7974e59bcd2dcc8631a6b6cc380a904725fce7bc08872e691615"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/cb/9f/27d4844ac5bf158a33900dbad7985951e2910397998e85712da03ce125f0/Pygments-2.5.2.tar.gz"
    sha256 "98c8aa5a9f778fcd1026a17361ddaf7330d1b7c62ae97c3bb0ae73e0b9b6b0fe"
  end

  resource "alabaster" do
    url "https://files.pythonhosted.org/packages/cc/b4/ed8dcb0d67d5cfb7f83c4d5463a7614cb1d078ad7ae890c9143edebbf072/alabaster-0.7.12.tar.gz"
    sha256 "a661d72d58e6ea8a57f7a86e37d86716863ee5e92788398526d58b26a4e4dc02"
  end

  resource "argh" do
    url "https://files.pythonhosted.org/packages/e3/75/1183b5d1663a66aebb2c184e0398724b624cecd4f4b679cb6e25de97ed15/argh-0.26.2.tar.gz"
    sha256 "e9535b8c84dc9571a48999094fda7f33e63c3f1b74f3e5f3ac0105a58405bb65"
  end

  resource "Babel" do
    url "https://files.pythonhosted.org/packages/34/18/8706cfa5b2c73f5a549fdc0ef2e24db71812a2685959cff31cbdfc010136/Babel-2.8.0.tar.gz"
    sha256 "1aac2ae2d0d8ea368fa90906567f5c08463d98ade155c0c4bfedd6a0f7160e38"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz"
    sha256 "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/2f/e0/3d435b34abd2d62e8206171892f174b180cd37b09d57b924ca5c2ef2219d/docutils-0.16.tar.gz"
    sha256 "c2de3a60e9e7d07be26b7f2b00ca0309c207e06c100f9cc2a94931fc75a478fc"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"
    sha256 "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"
  end

  resource "imagesize" do
    url "https://files.pythonhosted.org/packages/e4/9f/0452b459c8ba97e07c3cd2bd243783936a992006cf4cd1353c314a927028/imagesize-1.2.0.tar.gz"
    sha256 "b1f6b5a4eab1f73479a50fb79fcf729514a900c341d8503d62a62dbc4127a2b1"
  end

  resource "livereload" do
    url "https://files.pythonhosted.org/packages/27/26/85ba3851d2e4905be7d2d41082adca833182bb1d7de9dfc7f623383d36e1/livereload-2.6.1.tar.gz"
    sha256 "89254f78d7529d7ea0a3417d224c34287ebfe266b05e67e51facaf82c27f0f66"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/7b/d5/199f982ae38231995276421377b72f4a25d8251f4fa56f6be7cfcd9bb022/packaging-20.1.tar.gz"
    sha256 "e665345f9eef0c621aa0bf2f8d78cf6d21904eef16a93f020240b704a57f1334"
  end

  resource "pathtools" do
    url "https://files.pythonhosted.org/packages/e7/7f/470d6fcdf23f9f3518f6b0b76be9df16dcc8630ad409947f8be2eb0ed13a/pathtools-0.1.2.tar.gz"
    sha256 "7c35c5421a39bb82e58018febd90e3b6e5db34c5443aaaf742b3f33d4655f1c0"
  end

  resource "port-for" do
    url "https://files.pythonhosted.org/packages/cd/68/57f6d5cae15125acc0f3e2a5117de5e2d83f4e96c4d97e088122557b3d70/port-for-0.4.tar.gz"
    sha256 "47b5cb48f8e036497cd73b96de305cecb4070e9ecbc908724afcbd2224edccde"
  end

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/3a/80/0cdb2130b86a984e4765beb93135aa9c2120fd64be1a27e1c7cb31c719bc/pyobjc-core-6.1.tar.gz"
    sha256 "1a0fbf012fb575e0adf8c18cfd4453e657cc2c0deb2660c529bf524ba4c9149a"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/packages/7a/99/bfac679ee346f344bca72ee315249e56f4f34bc974345f66d7810380ce7a/pyobjc-framework-Cocoa-6.1.tar.gz"
    sha256 "c4077d2e6f96e4f3fd9780d66778cf51d27f414822498b24410e9df7a6a4d531"
  end

  resource "pyobjc-framework-FSEvents" do
    url "https://files.pythonhosted.org/packages/af/f9/0b3d5459abc72ee6bb823085c4029bd57ae94bdb6cd268ae84d6a4a43779/pyobjc-framework-FSEvents-6.1.tar.gz"
    sha256 "7a635c86af744a1d17f0c6c3913bef87b5fd146e0311c03229eba9e512b81520"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/a2/56/0404c03c83cfcca229071d3c921d7d79ed385060bbe969fde3fd8f774ebd/pyparsing-2.4.6.tar.gz"
    sha256 "4c830582a84fb022400b85429791bc551f1f4871c33f23e44f353119e92f969f"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/82/c3/534ddba230bd4fbbd3b7a3d35f3341d014cca213f369a9940925e7e5f691/pytz-2019.3.tar.gz"
    sha256 "b02c06db6cf09c12dd25137e563b31700d3b80fcc4ad23abb7a315f2789819be"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/01/62/ddcf76d1d19885e8579acb1b1df26a852b03472c0e46d2b959a714c90608/requests-2.22.0.tar.gz"
    sha256 "11e007a8a2aa0323f5a921e9e6a2d7e4e67d9877e85773fba9ba6419025cbeb4"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz"
    sha256 "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a"
  end

  resource "snowballstemmer" do
    url "https://files.pythonhosted.org/packages/21/1b/6b8bbee253195c61aeaa61181bb41d646363bdaa691d0b94b304d4901193/snowballstemmer-2.0.0.tar.gz"
    sha256 "df3bac3df4c2c01363f3dd2cfa78cce2840a79b9f1c2d2de9ce8d31683992f52"
  end

  resource "sphinx-autobuild" do
    url "https://files.pythonhosted.org/packages/41/21/d7407dd6258ca4f4dfe6b3edbd076702042c02bfcdd82b6f71cb58a359d2/sphinx-autobuild-0.7.1.tar.gz"
    sha256 "66388f81884666e3821edbe05dd53a0cfb68093873d17320d0610de8db28c74e"
  end

  resource "sphinxcontrib-applehelp" do
    url "https://files.pythonhosted.org/packages/1b/71/8bafa145e48131049dd4f731d6f6eeefe0c34c3017392adbec70171ad407/sphinxcontrib-applehelp-1.0.1.tar.gz"
    sha256 "edaa0ab2b2bc74403149cb0209d6775c96de797dfd5b5e2a71981309efab3897"
  end

  resource "sphinxcontrib-devhelp" do
    url "https://files.pythonhosted.org/packages/57/5f/bf9a0f7454df68a7a29033a5cf8d53d0797ae2e426b1b419e4622726ec7d/sphinxcontrib-devhelp-1.0.1.tar.gz"
    sha256 "6c64b077937330a9128a4da74586e8c2130262f014689b4b89e2d08ee7294a34"
  end

  resource "sphinxcontrib-htmlhelp" do
    url "https://files.pythonhosted.org/packages/f1/f2/88e9d6dc4a17f1e95871f8b634adefcc5d691334f7a121e9f384d1dc06fd/sphinxcontrib-htmlhelp-1.0.2.tar.gz"
    sha256 "4670f99f8951bd78cd4ad2ab962f798f5618b17675c35c5ac3b2132a14ea8422"
  end

  resource "sphinxcontrib-jsmath" do
    url "https://files.pythonhosted.org/packages/b2/e8/9ed3830aeed71f17c026a07a5097edcf44b692850ef215b161b8ad875729/sphinxcontrib-jsmath-1.0.1.tar.gz"
    sha256 "a9925e4a4587247ed2191a22df5f6970656cb8ca2bd6284309578f2153e0c4b8"
  end

  resource "sphinxcontrib-qthelp" do
    url "https://files.pythonhosted.org/packages/0c/f0/690cd10603e3ea8d184b2fffde1d965dd337b87a1d5f7625d0f6791094f4/sphinxcontrib-qthelp-1.0.2.tar.gz"
    sha256 "79465ce11ae5694ff165becda529a600c754f4bc459778778c7017374d4d406f"
  end

  resource "sphinxcontrib-serializinghtml" do
    url "https://files.pythonhosted.org/packages/cd/cc/fd7d17cfae18e5a92564bb899bc05e13260d7a633f3cffdaad4e5f3ce46a/sphinxcontrib-serializinghtml-1.1.3.tar.gz"
    sha256 "c0efb33f8052c04fd7a26c0a07f1678e8512e0faec19f4aa8f2473a8b81d5227"
  end

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/30/78/2d2823598496127b21423baffaa186b668f73cd91887fcef78b6eade136b/tornado-6.0.3.tar.gz"
    sha256 "c845db36ba616912074c5b1ee897f8e0124df269468f25e4fe21fe72f6edd7a9"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/09/06/3bc5b100fe7e878d3dee8f807a4febff1a40c213d2783e3246edde1f3419/urllib3-1.25.8.tar.gz"
    sha256 "87716c2d2a7121198ebcb7ce7cccf6ce5e9ba539041cfbaeecfb641dc0bf6acc"
  end

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/01/01/cc9b2fd111e19687dd42155f066718bccb414c8a728eb7df0b229742caf7/watchdog-0.10.0.tar.gz"
    sha256 "8e800496cdfb921cfdc62b58a11966d0d2203a35dc005b4b5b8e1ab3097b2eb5"
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
