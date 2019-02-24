class Confirm < Formula
  desc "Popup confirm utility for macOS"
  homepage "https://github.com/JarryShaw/confirm#confirm"
  url "https://github.com/JarryShaw/confirm/archive/v2018.12.15.tar.gz"
  sha256 "b3d2070d7f1d5a6c459985da5ef7e530ab48865f59f76b27b690481303edc1f9"

  def install
    bin.install "confirm"
  end

  test do
    system bin/"confirm", "--help"
  end
end
