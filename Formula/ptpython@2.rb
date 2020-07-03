class PtpythonAT2 < Formula
  include Language::Python::Virtualenv

  desc "Better Python REPL"
  homepage "https://github.com/prompt-toolkit/ptpython"
  url "https://files.pythonhosted.org/packages/ec/00/7db6b203f1cc9ebe316f76078a66feb64e175bde48412baf167d3bdf2ff3/ptpython-2.0.4.tar.gz"
  sha256 "ebe9d68ea7532ec8ab306d4bdc7ec393701cd9bbd6eff0aa3067c821f99264d4"

  head "https://github.com/bpython/bpython.git", :branch => "master"

  keg_only :versioned_formula

  option "with-ptipython", "build with IPython support"

  depends_on "python@2"
  if build.with?("ptipython")
    depends_on "zeromq"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"
    sha256 "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"
  end

  resource "appnope" do
    url "https://files.pythonhosted.org/packages/26/34/0f3a5efac31f27fabce64645f8c609de9d925fe2915304d1a40f544cff0e/appnope-0.1.0.tar.gz"
    sha256 "8b995ffe925347a2138d7ac0fe77155e4311a0ea6d6da4f5128fe4b3cbe5ed71"
  end

  resource "backports.shutil_get_terminal_size" do
    url "https://files.pythonhosted.org/packages/ec/9c/368086faa9c016efce5da3e0e13ba392c9db79e3ab740b763fe28620b18b/backports.shutil_get_terminal_size-1.0.0.tar.gz"
    sha256 "713e7a8228ae80341c70586d1cc0a8caa5207346927e23d09dcbcaf18eadec80"
  end

  resource "backports_abc" do
    url "https://files.pythonhosted.org/packages/68/3c/1317a9113c377d1e33711ca8de1e80afbaf4a3c950dd0edfaf61f9bfe6d8/backports_abc-0.5.tar.gz"
    sha256 "033be54514a03e255df75c5aee8f9e672f663f93abb723444caec8fe43437bde"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/6f/24/15a229626c775aae5806312f6bf1e2a73785be3402c0acdec5dbddd8c11e/decorator-4.3.0.tar.gz"
    sha256 "c39efa13fbdeb4506c476c9b3babf6a718da943dab7811c206005a4a956c080c"
  end

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "enum34" do
    url "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz"
    sha256 "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1"
  end

  resource "futures" do
    url "https://files.pythonhosted.org/packages/1f/9e/7b2ff7e965fc654592269f2906ade1c7d705f1bf25b7d469fa153f7d19eb/futures-3.2.0.tar.gz"
    sha256 "9ec02aa7d674acb8618afb127e27fde7fc68994c0437ad759fa094a574adb265"
  end

  resource "ipykernel" do
    url "https://files.pythonhosted.org/packages/52/a6/8cfaaa3a1ccdebe7f3eabcf6969101e32dbdf14bfb2443d1c021130ce23c/ipykernel-4.8.2.tar.gz"
    sha256 "c091449dd0fad7710ddd9c4a06e8b9e15277da306590bc07a3a1afa6b4453c8f"
  end

  resource "ipython" do
    url "https://files.pythonhosted.org/packages/41/a6/2d25314b1f9375639d8f8e0f8052e8cec5df511d3449f22c4f1c2d8cb3c6/ipython-5.8.0.tar.gz"
    sha256 "4bac649857611baaaf76bc82c173aa542f7486446c335fe1a6c05d0d491c8906"
  end

  resource "ipython_genutils" do
    url "https://files.pythonhosted.org/packages/e8/69/fbeffffc05236398ebfcfb512b6d2511c622871dca1746361006da310399/ipython_genutils-0.2.0.tar.gz"
    sha256 "eb2e116e75ecef9d4d228fdc66af54269afa26ab4463042e33785b887c628ba8"
  end

  resource "jedi" do
    url "https://files.pythonhosted.org/packages/e4/83/4c05db437252694660c972b5374b35a68a8a0a8cd012dc95e5fd4d7e71b0/jedi-0.13.2.tar.gz"
    sha256 "571702b5bd167911fe9036e5039ba67f820d6502832285cde8c881ab2b2149fd"
  end

  resource "jupyter_client" do
    url "https://files.pythonhosted.org/packages/4c/df/1e8df7f4de63cc667a7a9aa234539c0419513bf94ac57d36d73b3b434786/jupyter_client-5.2.3.tar.gz"
    sha256 "27befcf0446b01e29853014d6a902dd101ad7d7f94e2252b1adca17c3466b761"
  end

  resource "jupyter_core" do
    url "https://files.pythonhosted.org/packages/b6/2d/2804f4de3a95583f65e5dcb4d7c8c7183124882323758996e867f47e72af/jupyter_core-4.4.0.tar.gz"
    sha256 "ba70754aa680300306c699790128f6fbd8c306ee5927976cbe48adacf240c0b7"
  end

  resource "parso" do
    url "https://files.pythonhosted.org/packages/46/31/60de7c9cbb97cac56b193a5b61a1fd4d21df84843a570b370ec34781316b/parso-0.3.1.tar.gz"
    sha256 "35704a43a3c113cce4de228ddb39aab374b8004f4f2407d070b6a2ca784ce8a2"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/db/a8/7d6439c1aec525ed70810abee5b7d7f3aa35347f59bc28343e8f62019aa2/pathlib2-2.3.2.tar.gz"
    sha256 "8eb170f8d0d61825e09a95b38be068299ddeda82f35e96c3301a8a5e7604cb83"
  end

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/89/43/07d07654ee3e25235d8cea4164cdee0ec39d1fda8e9203156ebe403ffda4/pexpect-4.6.0.tar.gz"
    sha256 "2a8e88259839571d1251d278476f3eec5db26deb73a70be5ed5dc5435e418aba"
  end

  resource "pickleshare" do
    url "https://files.pythonhosted.org/packages/69/fe/dd137d84daa0fd13a709e448138e310d9ea93070620c9db5454e234af525/pickleshare-0.7.4.tar.gz"
    sha256 "84a9257227dfdd6fe1b4be1319096c20eb85ff1e82c7932f36efccfe1b09737b"
  end

  resource "prompt_toolkit" do
    url "https://files.pythonhosted.org/packages/8a/ad/cf6b128866e78ad6d7f1dc5b7f99885fb813393d9860778b2984582e81b5/prompt_toolkit-1.0.15.tar.gz"
    sha256 "858588f1983ca497f1cf4ffde01d978a3ea02b01c8a26a8bbc5cd2e66d816917"
  end

  resource "ptpython" do
    url "https://files.pythonhosted.org/packages/ec/00/7db6b203f1cc9ebe316f76078a66feb64e175bde48412baf167d3bdf2ff3/ptpython-2.0.4.tar.gz"
    sha256 "ebe9d68ea7532ec8ab306d4bdc7ec393701cd9bbd6eff0aa3067c821f99264d4"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/7d/2d/e4b8733cf79b7309d84c9081a4ab558c89d8c89da5961bf4ddb050ca1ce0/ptyprocess-0.6.0.tar.gz"
    sha256 "923f299cc5ad920c68f2bc0bc98b75b9f838b93b599941a6b63ddbc2476394c0"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/a0/b0/a4e3241d2dee665fea11baec21389aec6886655cd4db7647ddf96c3fad15/python-dateutil-2.7.3.tar.gz"
    sha256 "e27001de32f627c22380a688bcc43ce83504a7bc5da472209b4c70f02829f0b8"
  end

  resource "pyzmq" do
    url "https://files.pythonhosted.org/packages/aa/fd/f2e65a05558ff8b58b71404efc79c2b03cef922667260e1d703896597b93/pyzmq-17.1.0.tar.gz"
    sha256 "2199f753a230e26aec5238b0518b036780708a4c887d4944519681a920b9dee4"
  end

  resource "scandir" do
    url "https://files.pythonhosted.org/packages/13/bb/e541b74230bbf7a20a3949a2ee6631be299378a784f5445aa5d0047c192b/scandir-1.7.tar.gz"
    sha256 "b2d55be869c4f716084a19b1e16932f0769711316ba62de941320bf2be84763d"
  end

  resource "simplegeneric" do
    url "https://files.pythonhosted.org/packages/3d/57/4d9c9e3ae9a255cd4e1106bb57e24056d3d0709fc01b2e3e345898e49d5b/simplegeneric-0.8.1.zip"
    sha256 "dc972e06094b9af5b855b3df4a646395e43d1c9d0d39ed345b7393560d0b9173"
  end

  resource "singledispatch" do
    url "https://files.pythonhosted.org/packages/d9/e9/513ad8dc17210db12cb14f2d4d190d618fb87dd38814203ea71c87ba5b68/singledispatch-3.4.0.3.tar.gz"
    sha256 "5b06af87df13818d14f08a028e42f566640aef80805c3b50c5056b086e3c2b9c"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/45/ec/f2a03a0509bcfca336bef23a3dab0d07504893af34fd13064059ba4a0503/tornado-5.1.tar.gz"
    sha256 "4f66a2172cb947387193ca4c2c3e19131f1c70fa8be470ddbbd9317fd0801582"
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
      xy = Language::Python.major_minor_version "python"
      ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{xy}/site-packages"

      # install other resources
      ipython = resource("ipython")
      ptpython = resource("ptpython")
      ipykernel = resource("ipykernel")
      (resources - [ipython, ptpython, ipykernel]).each do |r|
        r.stage do
          system "python", *Language::Python.setup_install_args(libexec/"vendor")
        end
      end

      # install and link IPython
      ipython.stage do
        ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
        system "python", *Language::Python.setup_install_args(libexec)
        bin.install libexec/"bin/ipython"
        bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
      end

      # install IPython man page
      man1.install libexec/"share/man/man1/ipython.1"

      # install IPyKernel
      ipykernel.stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end

      # install kernel
      kernel_dir = Dir.mktmpdir
      system libexec/"bin/ipython", "kernel", "install", "--prefix", kernel_dir
      (share/"jupyter/kernels/python2").install Dir["#{kernel_dir}/share/jupyter/kernels/python2/*"]
      inreplace share/"jupyter/kernels/python2/kernel.json", "]", <<~EOS.chomp
        ],
        "env": {
          "PYTHONPATH": "#{ENV["PYTHONPATH"]}"
        }
      EOS

      # install and link ptPython
      ptpython.stage do
        ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
        system "python", *Language::Python.setup_install_args(libexec)
        bin.install Dir[libexec/"bin/ptpython*"]
        bin.install Dir[libexec/"bin/ptipython*"]
        bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
      end
    else
      venv = virtualenv_create(libexec, "python")

      %w[docopt jedi parso prompt_toolkit Pygments six wcwidth].each do |r|
        venv.pip_install resource(r)
      end

      venv.pip_install_and_link buildpath
    end
  end

  def post_install
    if build.with?("ptipython")
      rm_rf etc/"jupyter/kernels/python2"
      (etc/"jupyter/kernels/python2").install Dir[share/"jupyter/kernels/python2/*"]
    end
  end

  test do
    if build.with?("ptipython")
      assert_equal "4", shell_output("#{bin}/ipython -c 'print 2+2'").chomp

      system bin/"ipython", "kernel", "install", "--prefix", testpath
      assert_predicate testpath/"share/jupyter/kernels/python2/kernel.json", :exist?, "Failed to install kernel"
    end

    version = `#{libexec}/"bin/python" -c "print('%s.%s' % __import__('sys').version_info[:2])"`
    system bin/"ptpython#{version}", "--help"
  end
end
