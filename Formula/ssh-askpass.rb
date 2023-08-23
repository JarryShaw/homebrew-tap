class SshAskpass < Formula
  desc "macOS SSH AskPass utility"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.4.1.tar.gz"
  sha256 "a9a5439a422b544fb420fdbe77b3957a50137a509e31eb4fd00e57039749e009"

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
