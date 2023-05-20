class Pydl < Formula
  include Language::Python::Virtualenv

  desc "Video downloader powered by jarryshaw.me"
  homepage "https://jarryshaw.me"
  url "https://github.com/JarryShaw/pydl.git"
  version "2023.5.20"

  depends_on "homebrew/core/aria2"
  depends_on "homebrew/core/python@3.9"

  resource "certifi" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "charset-normalizer" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "idna" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "certifi" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "charset-normalizer" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "idna" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "requests" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/e0/69/122171604bcef06825fa1c05bd9e9b1d43bc9feb8c6c0717c42c92cc6f3c/requests-2.30.0.tar.gz"
    sha256 "239d7d4458afcb28a692cdd298d87542235f4ca8d36d03a15bfc128a6559a2f4"
  end

  resource "urllib3" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/fb/c0/1abba1a1233b81cf2e36f56e05194f5e8a0cec8c03c244cab56cc9dfb5bd/urllib3-2.0.2.tar.gz"
    sha256 "61717a1095d7e155cdb737ac7bb2f4324a858a1e2e6466f6d03ff630ca68d3cc"
  end

  resource "urllib3" do
    url "https://pypi.tuna.tsinghua.edu.cn/packages/fb/c0/1abba1a1233b81cf2e36f56e05194f5e8a0cec8c03c244cab56cc9dfb5bd/urllib3-2.0.2.tar.gz"
    sha256 "61717a1095d7e155cdb737ac7bb2f4324a858a1e2e6466f6d03ff630ca68d3cc"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin/"dl-add", "--help"
  end
end
