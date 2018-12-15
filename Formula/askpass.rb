class Askpass < Formula
  desc "AskPass utility for macOS"
  homepage "https://github.com/JarrySaw/askpass#askpass"
  url "https://github.com/JarryShaw/askpass/archive/v2018.12.15.tar.gz"
  sha256 "285e52794db4d1e5d230b115db138cc9b5fcd5e0171c41e3b540e41c540bf357"

  # conflicts_with "theseal/ssh-askpass/ssh-askpass", :because => "jarryshaw/tap/askpass also ships a askpass binary"

  def install
    bin.install "askpass"
  end

  def caveats; <<~EOF
    NOTE:
      After you have started the launchd service (read below),
      you need to log out and in (reboot might be easiest)
      before you can add keys to the agent with `ssh-add -c`.
    EOF
  end

  plist_options :startup => "true"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
                <key>Label</key>
                <string>#{plist_name}</string>
                <key>ProgramArguments</key>
                <array>
                        <string>/usr/bin/ssh-agent</string>
                        <string>-l</string>
                </array>
                <key>EnvironmentVariables</key>
                <dict>
                        <key>SSH_ASKPASS</key>
                        <string>#{opt_bin}/askpass</string>
                        <key>DISPLAY</key>
                        <string>0</string>
                </dict>
                <key>Sockets</key>
                <dict>
                        <key>Listeners</key>
                        <dict>
                                <key>SecureSocketWithKey</key>
                                <string>SSH_AUTH_SOCK</string>
                        </dict>
                </dict>
                <key>EnableTransactions</key>
                <true/>
        </dict>
        </plist>
    EOS
  end

  test do
    system bin/"askpass", "--help"
  end
end
