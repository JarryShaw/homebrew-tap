class F2format < Formula
  include Language::Python::Virtualenv

  version "0.4.0.post2"
  desc "Back-port compiler for Python 3.6 f-string literals."
  homepage "https://github.com/JarryShaw/f2format#f2format"
  url "https://files.pythonhosted.org/packages/44/5d/46ad0cc7d327dfbdc3f6aeb82b242e09dd19606585c0196ebc7ac01a53a3/f2format-0.4.0.post2.tar.gz"
  sha256 "96f06428b29e415a162ced5e446b72bd5910842f6f02055f4b02578f644e2250"
  head "https://github.com/JarryShaw/f2format.git", :branch => "master"

  bottle :unneeded

  devel do
    url "https://codeload.github.com/JarryShaw/f2format/tar.gz/v0.4.0.post2"
    sha256 "0191822ffc688df4e24ebeeb6f6734f209bbf3922a489f9b50500a1731419b92"
  end

  depends_on "python"

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/db/a8/7d6439c1aec525ed70810abee5b7d7f3aa35347f59bc28343e8f62019aa2/pathlib2-2.3.2.tar.gz"
    sha256 "8eb170f8d0d61825e09a95b38be068299ddeda82f35e96c3301a8a5e7604cb83"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "typed-ast" do
    url "https://files.pythonhosted.org/packages/52/cf/2ebc7d282f026e21eed4987e42e10964a077c13cfc168b42f3573a7f178c/typed-ast-1.1.0.tar.gz"
    sha256 "57fe287f0cdd9ceaf69e7b71a2e94a24b5d268b35df251a88fef5cc241bf73aa"
  end

  def install
    # virtualenv_install_with_resources
    venv = virtualenv_create(libexec, "python3")

    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    if ( version =~ /3.[34]/ )
      %w[pathlib2 six].each do |r|
        venv.pip_install resource(r)
      end
    end

    if ( version =~ /3.[345]/ )
      venv.pip_install resource("typed-ast")
    end
    venv.pip_install_and_link buildpath
  end

  test do
    system bin/"f2format", "--help"
  end
end
