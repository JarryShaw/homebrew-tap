class Confirm < Formula
  desc "Confirm utility for macOS"
  homepage "https://github.com/JarrySaw/confirm#confirm"
  url "https://github.com/JarryShaw/confirm/archive/v2018.12.15.tar.gz"
  sha256 "285e52794db4d1e5d230b115db138cc9b5fcd5e0171c41e3b540e41c540bf357"

  def install
    bin.install "confirm"
  end

  test do
    system bin/"confirm", "--help"
  end
end
