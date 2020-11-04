class Pkt2flow < Formula
  desc "Simple utility to classify packets into flows"
  homepage "https://github.com/caesar0301/pkt2flow#pkt2flow"
  url "https://github.com/caesar0301/pkt2flow/archive/v1.3.tar.gz"
  sha256 "01dd44c1be8b11e0ed708cb2992ff58a0ddfc2f405fa41864064e336e9cdf219"

  head "https://github.com/caesar0301/pkt2flow.git", branch: "master"

  depends_on "scons" => :build
  depends_on "libpcap"

  def install
    cd buildpath
    system "scons"
    bin.install "pkt2flow"
  end

  test do
    system bin/"pkt2flow", "-h"
  end
end
