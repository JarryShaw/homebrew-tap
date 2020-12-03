class Pyinstaller < Formula
  include Language::Python::Virtualenv

  desc "Bundle a Python application and all its dependencies"
  homepage "https://www.pyinstaller.org"
  url "https://files.pythonhosted.org/packages/9e/ed/fbdad7f5d8f794c901076b814b8e9f5ce31d32c0bc3b63ddd27b61db9530/pyinstaller-4.1.tar.gz"
  sha256 "954ae81de9a4bc096ff02433b3e245b9272fe53f27cac319e71fe7540952bd3d"
  license "GPL-2.0"
  head "https://github.com/pyinstaller/pyinstaller.git", branch: "develop"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "6518b7fb92db54abc227d3be74530c65d08ef75b79d7d8e5aa3655a31bfb8a31" => :big_sur
    sha256 "4bccc73cc20b297d0ce9f8133c0fac8b7366323785fa83d3f7001cc136fd4918" => :catalina
    sha256 "4fbfb39966796c5fd73366fa0799b7e9260b3fcc8863838695516b922c237c02" => :mojave
  end

  depends_on "homebrew/core/python@3.9"

  conflicts_with "homebrew/core/pyinstaller", because: "it is now integrated with homebrew-core"

  resource "altgraph" do
    url "https://files.pythonhosted.org/packages/22/5a/ac50b52581bbf0d8f6fd50ad77d20faac19a2263b43c60e7f3af8d1ec880/altgraph-0.17.tar.gz"
    sha256 "1f05a47122542f97028caf78775a095fbe6a2699b5089de8477eb583167d69aa"
  end

  resource "macholib" do
    url "https://files.pythonhosted.org/packages/0d/fe/61e8f6b569c8273a8f2dd73921738239e03a2acbfc55be09f8793261f269/macholib-1.14.tar.gz"
    sha256 "0c436bc847e7b1d9bda0560351bf76d7caf930fb585a828d13608839ef42c432"
  end

  resource "pyinstaller-hooks-contrib" do
    url "https://files.pythonhosted.org/packages/a3/a9/ea55eba430824703625d37a01ff8a219643f3174a4afea1a4073ce5a0db0/pyinstaller-hooks-contrib-2020.10.tar.gz"
    sha256 "bf4543a16c9c6e9dd2d70ea3fee78b81d3357a68f706df471d990213892259d9"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    xy = Language::Python.major_minor_version "python3.9"
    system bin/"pyinstaller", "-F", "--distpath=#{testpath}/dist", "--workpath=#{testpath}/build",
                              libexec/"lib/python#{xy}/site-packages/easy_install.py"
    assert_predicate testpath/"dist/easy_install", :exist?
  end
end
