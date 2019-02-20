class Uti < Formula
  desc "CLI tool for interacting with File Type Identifiers on Mac"
  homepage "https://github.com/alexaubry/uti"
  url "https://github.com/alexaubry/uti.git",
    :tag      => "1.0.1",
    :revision => "1d780872175f8c3d6e5db950324cdf7f4eaaec38",
    :shallow  => false

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox", "--static-swift-stdlib"
    bin.install ".build/release/uti"
  end

  test do
    system "swift", "test"
  end
end
