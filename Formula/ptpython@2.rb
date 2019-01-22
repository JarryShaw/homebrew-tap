class PtpythonAT2 < Formula
  include Language::Python::Virtualenv

  desc "Better Python REPL"
  homepage "https://github.com/prompt-toolkit/ptpython"
  url "https://files.pythonhosted.org/packages/ec/00/7db6b203f1cc9ebe316f76078a66feb64e175bde48412baf167d3bdf2ff3/ptpython-2.0.4.tar.gz"
  sha256 "ebe9d68ea7532ec8ab306d4bdc7ec393701cd9bbd6eff0aa3067c821f99264d4"

  head "https://github.com/bpython/bpython.git", :branch => "master"

  depends_on "python@2"

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "jedi" do
    url "https://files.pythonhosted.org/packages/e4/83/4c05db437252694660c972b5374b35a68a8a0a8cd012dc95e5fd4d7e71b0/jedi-0.13.2.tar.gz"
    sha256 "571702b5bd167911fe9036e5039ba67f820d6502832285cde8c881ab2b2149fd"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/46/31/60de7c9cbb97cac56b193a5b61a1fd4d21df84843a570b370ec34781316b/parso-0.3.1.tar.gz"
    sha256 "35704a43a3c113cce4de228ddb39aab374b8004f4f2407d070b6a2ca784ce8a2"
  end

  resource "prompt_toolkit" do
    url "https://files.pythonhosted.org/packages/d9/a5/4b2dd1a05403e34c3ba0d9c00f237c01967c0a4f59a427c9b241129cdfe4/prompt_toolkit-2.0.7.tar.gz"
    sha256 "fd17048d8335c1e6d5ee403c3569953ba3eb8555d710bfc548faf0712666ea39"
  end

  resource "ptpython" do
    url "https://files.pythonhosted.org/packages/ec/00/7db6b203f1cc9ebe316f76078a66feb64e175bde48412baf167d3bdf2ff3/ptpython-2.0.4.tar.gz"
    sha256 "ebe9d68ea7532ec8ab306d4bdc7ec393701cd9bbd6eff0aa3067c821f99264d4"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/64/69/413708eaf3a64a6abb8972644e0f20891a55e621c6759e2c3f3891e05d63/Pygments-2.3.1.tar.gz"
    sha256 "5ffada19f6203563680669ee7f53b64dabbeb100eb51b61996085e99c03b284a"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz"
    sha256 "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    system bin/"ptpython#{version}", "--help"
  end
end
