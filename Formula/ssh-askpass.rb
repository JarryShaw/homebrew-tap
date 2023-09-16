class SshAskpass < Formula
  desc "macOS SSH AskPass utility"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.4.2.tar.gz"
  sha256 "b5e0ffd2745caa2d7f3f302f55755cb613fbfbdcecf3572a7afbf02e88d948f7"

  def install
    bin.install name.to_s
    # The label in the plist must be #{plist_name} in order for `brew services` to work
    # See https://github.com/Homebrew/homebrew-services/issues/376
    plist = "#{name}.plist"
    inreplace plist, %r{<string>com.github.theseal.ssh-askpass</string>}, "<string>#{plist_name}</string>"
    inreplace plist, %r{/usr/local/bin}, "#{opt_prefix}/bin"
    prefix.install plist => "#{plist_name}.plist"
  end

  def caveats
    <<~EOF
      NOTE: You will need to run the following to load the SSH_ASKPASS environment variable:
        brew services start #{name}
    EOF
  end

  test do
    system "true"
  end
end
