class SshAskpass < Formula
  desc "macOS SSH AskPass utility"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.5.1.tar.gz"
  sha256 "7497125e452e1cfe671ac05dbb4640f5d82ba6961950c0e519a00afdd8be0880"

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

  service do
    name macos: "#{plist_name}"
  end
end
