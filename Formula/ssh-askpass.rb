class SshAskpass < Formula
  desc "macOS SSH AskPass utility"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.5.0.tar.gz"
  sha256 "a519843354c3c0c20327dfacb918c8031ddba41d04245262cbbd0ae5524c341b"

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
