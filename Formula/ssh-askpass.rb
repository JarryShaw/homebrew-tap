class SshAskpass < Formula
  desc "SSH AskPass util for MacOS"
  homepage "https://github.com/theseal/ssh-askpass/"
  url "https://github.com/theseal/ssh-askpass/archive/v1.2.1.tar.gz"
  sha256 "285e52794db4d1e5d230b115db138cc9b5fcd5e0171c41e3b540e41c540bf357"

  def install
    bin.install "ssh-askpass"
  end

  def caveats
    text = <<~EOF
      NOTE: After you have started the launchd service (read below) you need to log out and in (reboot might be easiest) before you can add keys to the agent with `ssh-add -c`.
    EOF
    text
  end

  plist_options :startup => "true"

  def plist
    file = <<~EOS
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
                      <string>#{opt_bin}/ssh-askpass</string>
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
    file
  end

  test do
    system "true"
  end
end
