class BroPkg < Formula
  include Language::Python::Virtualenv

  desc "Package manager for Zeek"
  homepage "https://docs.zeek.org/projects/package-manager"
  url "https://github.com/zeek/package-manager/archive/v1.5.2.tar.gz"
  sha256 "329ed60270931bf6fdbc46f5835be5e582dc6f0f7a6a7ff40aeccb9454eae35e"

  head "https://github.com/zeek/package-manager.git", :branch => "master"

  depends_on "bro"
  depends_on "python"

  resource "btest" do
    url "https://files.pythonhosted.org/packages/de/ef/a0169d0503d9f987e8b10f4daed0b1f1f7693e22710c21ee6fdddbb705a4/btest-0.58.tar.gz"
    sha256 "632f88977e1091cec2edf853826c8b0233f6839a6bf490217e3947d8ba342402"
  end

  resource "configparser" do
    url "https://files.pythonhosted.org/packages/4a/4d/5d4c07cd28476ecad84ea5ad43961e50b6fd74cd24b9b81113650b4de6ee/configparser-3.7.3.tar.gz"
    sha256 "27594cf4fc279f321974061ac69164aaebd2749af962ac8686b20503ac0bcf2d"
  end

  resource "gitdb2" do
    url "https://files.pythonhosted.org/packages/c4/5c/579abccd59187eaf6b3c8a4a6ecd86fce1dfd818155bfe4c52ac28dca6b7/gitdb2-2.0.5.tar.gz"
    sha256 "83361131a1836661a155172932a13c08bda2db3674e4caa32368aa6eb02f38c2"
  end

  resource "GitPython" do
    url "https://files.pythonhosted.org/packages/4d/e8/98e06d3bc954e3c5b34e2a579ddf26255e762d21eb24fede458eff654c51/GitPython-2.1.11.tar.gz"
    sha256 "8237dc5bfd6f1366abeee5624111b9d6879393d84745a507de0fda86043b65a8"
  end

  resource "semantic_version" do
    url "https://files.pythonhosted.org/packages/72/83/f76958017f3094b072d8e3a72d25c3ed65f754cc607fdb6a7b33d84ab1d5/semantic_version-2.6.0.tar.gz"
    sha256 "2a4328680073e9b243667b201119772aefc5fc63ae32398d6afafff07c4f54c0"
  end

  resource "smmap2" do
    url "https://files.pythonhosted.org/packages/3b/ba/e49102b3e8ffff644edded25394b2d22ebe3e645f3f6a8139129c4842ffe/smmap2-2.0.5.tar.gz"
    sha256 "29a9ffa0497e7f2be94ca0ed1ca1aa3cd4cf25a1f6b4f5f87f74b46ed91d609a"
  end

  def install
    virtualenv_install_with_resources
  end

  # def post_install
  #   system bin/"bro-pkg", "autoconfig"
  # end

  def caveats
    text = <<~EOS
      bro-pkg has been installed as
        #{HOMEBREW_PREFIX}/bin/bro-pkg

      To perform postinstall process, please directly call the
      following command: `bro-pkg autoconfig`.

      Configuration file locates at ~/.bro-pkg/config, please
      run `bro-pkg config` command to set up your runtime
      specifications.

      For more information, check out `bro-pkg --help` command.
      Online documentations available at GitHub repository.

      See: https://docs.zeek.org/projects/package-manager
    EOS
    text
  end

  test do
    system bin/"bro-pkg", "--help"
  end
end
