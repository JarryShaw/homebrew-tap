class SshAskpass < Formula
  desc "macOS SSH AskPass utility"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.4.0.tar.gz"
  sha256 "9f13178d3856e7b280f8cc07bb7e755d8d1cd4ee4411fd48ffaa3235fcef9c32"

  def install
    bin.install name.to_s
    # The label in the plist must be #{plist_name} in order for `brew services` to work
    # See https://github.com/Homebrew/homebrew-services/issues/376
    inreplace "ssh-askpass.plist", %r{<string>com.github.theseal.ssh-askpass</string>},
"<string>#{plist_name}</string>"
    inreplace "ssh-askpass.plist", %r{/usr/local/bin}, "#{opt_prefix}/bin"
    prefix.install "#{name}.plist" => "#{plist_name}.plist"
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
