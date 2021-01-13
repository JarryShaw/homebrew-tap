class Dart < Formula
  desc "SDK for dart language"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "45c28ed3eb036edd1f5b0a7a073afddd1900f96abc3be085fe9335a424a228b4"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "789f56cb6da0cfb2b97d9ea0942bc3f26fc20fd86256b1101e0147aa9790585e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "280701c2a225ef08bc14f5a2e7e2c75350b1ae3d78f7fd27cbb2a0b66674d83b"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "13f085e477f93aa3884dbbcaaacb77c08d8ab6712b332a4f399b39f4c11be410"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9f41091c8542fd50f0bd60fa9e5d4ceefe9c754a21684f802f89b54d2abeec83"
    end
  end

  head do
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-205.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e551f9883c1542fd6e3944c67a2850df184ad93b9a53c726ec7db7f532727d72"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-205.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "01b37f1ff8b5c7cb70df35148d210e2e4c9c77f09d2e9fb5685a0473525c1a74"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-205.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "b376947e7306b84e39fb5628149805d235654ce51834caf6fa5ba66612936abe"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-205.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "887a7679acf6448a42978c8afb2c85c78abc62854a2071ec58116cd17c16ca26"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.12.0-205.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "5b974de2e7dc02699253fcfacbf520fcef7201716bca5f49b05917caa1bdae16"
      end
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
      Please note the path to the Dart SDK:
        #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
