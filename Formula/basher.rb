class Basher < Formula
  desc "Package manager for shell scripts"
  homepage "https://github.com/basherpm/basher"
  url "https://github.com/basherpm/basher.git",
    revision: "ad0f1b7bf710f5f6a1d10cc3ac39af8f558b4765"
  version "2021.3.20"

  def install
    Dir["*"].each do |f|
      cp_r f, prefix/f.to_s
    end

    bash_completion.install "completions/basher.bash"
    zsh_completion.install "completions/basher.zsh"
  end

  def caveats
    <<~EOS
      To make basher work smoothly, link it to your home directory
        ln -s /usr/local/opt/basher ~/.basher

      Add `basher init` to your shell to enable basher runtime functions
        echo 'eval "$(basher init -)"' >> ~/.bash_profile

      For Fish, use the following line on your ~/.config/fish/config.fish.
        status --is-interactive; and . (basher init -|psub)
    EOS
  end

  test do
    system bin/"basher", "commands"
  end
end
