class Basher < Formula
  desc "Package manager for shell scripts"
  homepage "https://github.com/basherpm/basher"
  url "https://github.com/basherpm/basher.git",
    revision: "975ace3d25aee7444f9094373a8b792311dffe9e"
  version "2021.4.6"

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
