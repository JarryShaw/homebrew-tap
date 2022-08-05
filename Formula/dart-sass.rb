# typed: false
# frozen_string_literal: true

require "yaml"

# A formula for the Sass CLI.
class DartSass < Formula
  desc "Dart implementation of a Sass compiler"
  homepage "https://sass-lang.com"

  url "https://github.com/sass/dart-sass/archive/1.54.3.tar.gz"
  sha256 "fbfe1590ef63998b62d108b2dd848ea71456e910c50405b0ae7fadc43212472b"

  depends_on "jarryshaw/tap/dart" => :build

  conflicts_with "homebrew/core/node-sass", because: "both install a `sass` binary"

  def install
    # Tell the pub server where these installations are coming from.
    ENV["PUB_ENVIRONMENT"] = "homebrew:sass"

    system _dart/"dart", "pub", "get"
    # Build a native-code executable on 64-bit systems only. 32-bit Dart
    # doesn't support this.
    if Hardware::CPU.is_64_bit?
      _install_native_executable
    else
      _install_script_snapshot
    end
    chmod 0555, "#{bin}/sass"
  end

  test do
    (testpath/"test.scss").write(".class {property: 1 + 1}")
    assert_match "property: 2;", shell_output("#{bin}/sass test.scss 2>&1")
  end

  private

  def _dart
    @_dart ||= Formula["jarryshaw/tap/dart"].libexec/"bin"
  end

  def _version
    @_version ||= YAML.safe_load(File.read("pubspec.yaml"))["version"]
  end

  def _install_native_executable
    system _dart/"dart", "compile", "exe", "-Dversion=#{_version}",
           "bin/sass.dart", "-o", "sass"
    bin.install "sass"
  end

  def _install_script_snapshot
    system _dart/"dart", "compile", "jit-snapshot",
           "-Dversion=#{_version}",
           "-o", "sass.dart.app.snapshot",
           "bin/sass.dart", "tool/app-snapshot-input.scss"
    lib.install "sass.dart.app.snapshot"

    # Copy the version of the Dart VM we used into our lib directory so that if
    # the user upgrades their Dart VM version it doesn't break Sass's snapshot,
    # which was compiled with an older version.
    cp _dart/"dart", lib

    (bin/"sass").write <<~SH
      #!/bin/sh
      exec "#{lib}/dart" "#{lib}/sass.dart.app.snapshot" "$@"
    SH
  end
end
