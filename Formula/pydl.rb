class Pydl < Formula
  include Language::Python::Virtualenv

  desc "Video downloader powered by jarryshaw.me"
  homepage "https://jarryshaw.me"
  url "https://github.com/JarryShaw/pydl.git"
  version "2020.11.9"

  depends_on "homebrew/core/aria2"
  depends_on "homebrew/core/python@3.9"

  resource "certifi" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/e6/de/879cf857ae6f890dfa23c3d6239814c5471936b618c8fb0c8732ad5da885/certifi-2020.11.8.tar.gz"
    sha256 "f05def092c44fbf25834a51509ef6e631dc19765ab8a57b4e7ab85531f0a9cf4"
  end

  resource "chardet" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "idna" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "certifi" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/e6/de/879cf857ae6f890dfa23c3d6239814c5471936b618c8fb0c8732ad5da885/certifi-2020.11.8.tar.gz"
    sha256 "f05def092c44fbf25834a51509ef6e631dc19765ab8a57b4e7ab85531f0a9cf4"
  end

  resource "chardet" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "idna" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "requests" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/da/67/672b422d9daf07365259958912ba533a0ecab839d4084c487a5fe9a5405f/requests-2.24.0.tar.gz"
    sha256 "b3559a131db72c33ee969480840fff4bb6dd111de7dd27c8ee1f820f4f00231b"
  end

  resource "urllib3" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/76/d9/bbbafc76b18da706451fa91bc2ebe21c0daf8868ef3c30b869ac7cb7f01d/urllib3-1.25.11.tar.gz"
    sha256 "8d7eaa5a82a1cac232164990f04874c594c9453ec55eef02eab885aa02fc17a2"
  end

  resource "urllib3" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/76/d9/bbbafc76b18da706451fa91bc2ebe21c0daf8868ef3c30b869ac7cb7f01d/urllib3-1.25.11.tar.gz"
    sha256 "8d7eaa5a82a1cac232164990f04874c594c9453ec55eef02eab885aa02fc17a2"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dl-add", "--help"
  end
end
