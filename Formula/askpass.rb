class Askpass < Formula
  desc "Popup AskPass utility for macOS"
  homepage "https://github.com/JarryShaw/askpass#askpass"
  url "https://github.com/JarryShaw/askpass/archive/v2018.12.15.tar.gz"
  sha256 "0b994fcea968693f7b34513c3d74c21bc73c1aa3ad4f34c5a14d9f9f431aac1d"

  def install
    bin.install "askpass"
  end

  def caveats
    <<~EOS
      NOTE:
        After you have started the launchd service (read below),
        you need to log out and in (reboot might be easiest)
        before you can add keys to the agent with `ssh-add -c`.
    EOS
  end

  plist_options startup: "true"

  def plist
    <<~EOS
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
