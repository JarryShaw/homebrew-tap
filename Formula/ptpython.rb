class Ptpython < Formula
  include Language::Python::Virtualenv

  desc "Better Python REPL"
  homepage "https://github.com/prompt-toolkit/ptpython"
  url "https://files.pythonhosted.org/packages/ec/00/7db6b203f1cc9ebe316f76078a66feb64e175bde48412baf167d3bdf2ff3/ptpython-2.0.4.tar.gz"
  sha256 "ebe9d68ea7532ec8ab306d4bdc7ec393701cd9bbd6eff0aa3067c821f99264d4"

  head "https://github.com/bpython/bpython.git", branch: "master"

  option "with-ptipython", "build with IPython support"

  depends_on "python"
  depends_on "zeromq" if build.with?("ptipython")

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/64/69/413708eaf3a64a6abb8972644e0f20891a55e621c6759e2c3f3891e05d63/Pygments-2.3.1.tar.gz"
    sha256 "5ffada19f6203563680669ee7f53b64dabbeb100eb51b61996085e99c03b284a"
  end

  resource "appnope" do
    url "https://files.pythonhosted.org/packages/26/34/0f3a5efac31f27fabce64645f8c609de9d925fe2915304d1a40f544cff0e/appnope-0.1.0.tar.gz"
    sha256 "8b995ffe925347a2138d7ac0fe77155e4311a0ea6d6da4f5128fe4b3cbe5ed71"
  end

  resource "backcall" do
    url "https://files.pythonhosted.org/packages/84/71/c8ca4f5bb1e08401b916c68003acf0a0655df935d74d93bf3f3364b310e0/backcall-0.1.0.tar.gz"
    sha256 "38ecd85be2c1e78f77fd91700c76e14667dc21e2713b63876c0eb901196e01e4"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/6f/24/15a229626c775aae5806312f6bf1e2a73785be3402c0acdec5dbddd8c11e/decorator-4.3.0.tar.gz"
    sha256 "c39efa13fbdeb4506c476c9b3babf6a718da943dab7811c206005a4a956c080c"
  end

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "ipython" do
    url "https://files.pythonhosted.org/packages/42/bb/0ed1fb1d57d697326f9e9b827d9a74b81dee56031ed7c252bc716195ad7a/ipython-7.2.0.tar.gz"
    sha256 "6a9496209b76463f1dec126ab928919aaf1f55b38beb9219af3fe202f6bbdd12"
  end

  resource "ipython_genutils" do
    url "https://files.pythonhosted.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz"
    sha256 "eb2e116e75ecef9d4d228fdc66af54269afa26ab4463042e33785b887c628ba8"
  end

  resource "jedi" do
    url "https://files.pythonhosted.org/packages/e4/83/4c05db437252694660c972b5374b35a68a8a0a8cd012dc95e5fd4d7e71b0/jedi-0.13.2.tar.gz"
    sha256 "571702b5bd167911fe9036e5039ba67f820d6502832285cde8c881ab2b2149fd"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/46/31/60de7c9cbb97cac56b193a5b61a1fd4d21df84843a570b370ec34781316b/parso-0.3.1.tar.gz"
    sha256 "35704a43a3c113cce4de228ddb39aab374b8004f4f2407d070b6a2ca784ce8a2"
  end

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/89/43/07d07654ee3e25235d8cea4164cdee0ec39d1fda8e9203156ebe403ffda4/pexpect-4.6.0.tar.gz"
    sha256 "2a8e88259839571d1251d278476f3eec5db26deb73a70be5ed5dc5435e418aba"
  end

  resource "pickleshare" do
    url "https://files.pythonhosted.org/packages/d8/b6/df3c1c9b616e9c0edbc4fbab6ddd09df9535849c64ba51fcb6531c32d4d8/pickleshare-0.7.5.tar.gz"
    sha256 "87683d47965c1da65cdacaf31c8441d12b8044cdec9aca500cd78fc2c683afca"
  end

  resource "prompt_toolkit" do
    url "https://files.pythonhosted.org/packages/d9/a5/4b2dd1a05403e34c3ba0d9c00f237c01967c0a4f59a427c9b241129cdfe4/prompt_toolkit-2.0.7.tar.gz"
    sha256 "fd17048d8335c1e6d5ee403c3569953ba3eb8555d710bfc548faf0712666ea39"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/7d/2d/e4b8733cf79b7309d84c9081a4ab558c89d8c89da5961bf4ddb050ca1ce0/ptyprocess-0.6.0.tar.gz"
    sha256 "923f299cc5ad920c68f2bc0bc98b75b9f838b93b599941a6b63ddbc2476394c0"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"
    sha256 "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"
  end

  resource "traitlets" do
    url "https://files.pythonhosted.org/packages/a5/98/7f5ef2fe9e9e071813aaf9cb91d1a732e0a68b6c44a32b38cb8e14c3f069/traitlets-4.3.2.tar.gz"
    sha256 "9c4bd2d267b7153df9152698efb1050a5d84982d3384a37b2c1f7723ba3e7835"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz"
    sha256 "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e"
  end

  def install
    if build.with?("ptipython")
      xy = Language::Python.major_minor_version "python3"
      ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{xy}/site-packages"

      # install other resources
      ipython = resource("ipython")
      ptpython = resource("ptpython")
      ipykernel = resource("ipykernel")
      (resources - [ipython, ptpython, ipykernel]).each do |r|
        r.stage do
          system "python3", *Language::Python.setup_install_args(libexec/"vendor")
        end
      end

      # install and link IPython
      ipython.stage do
        ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
        system "python3", *Language::Python.setup_install_args(libexec)
        bin.install libexec/"bin/ipython"
        bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
      end

      # install IPython man page
      man1.install libexec/"share/man/man1/ipython.1"

      # install IPyKernel
      ipykernel.stage do
        system "python3", *Language::Python.setup_install_args(libexec/"vendor")
      end

      # install kernel
      kernel_dir = Dir.mktmpdir
      system libexec/"bin/ipython", "kernel", "install", "--prefix", kernel_dir
      (share/"jupyter/kernels/python3").install Dir["#{kernel_dir}/share/jupyter/kernels/python3/*"]
      inreplace share/"jupyter/kernels/python3/kernel.json", "]", <<~EOS
        ],
        "env": {
          "PYTHONPATH": "#{ENV["PYTHONPATH"]}"
        }
      EOS

      # install and link ptPython
      ptython.stage do
        ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
        system "python3", *Language::Python.setup_install_args(libexec)
        bin.install Dir[libexec/"bin/ptpython*"]
        bin.install Dir[libexec/"bin/ptipython*"]
        bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
      end
    else
      venv = virtualenv_create(libexec, "python3")

      %w[docopt jedi parso prompt_toolkit Pygments six wcwidth].each do |r|
        venv.pip_install resource(r)
      end

      venv.pip_install_and_link buildpath
    end
  end

  def post_install
    if build.with?("ptipython")
      rm_rf etc/"jupyter/kernels/python3"
      (etc/"jupyter/kernels/python3").install Dir[share/"jupyter/kernels/python3/*"]
    end
  end

  test do
    if build.with?("ptipython")
      assert_equal "4", shell_output("#{bin}/ipython -c 'print(2+2)'").chomp

      system bin/"ipython", "kernel", "install", "--prefix", testpath
      assert_predicate testpath/"share/jupyter/kernels/python3/kernel.json", :exist?, "Failed to install kernel"
    end

    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    system bin/"ptpython#{version}", "--help"
  end
end
