class Basher < Formula
  desc "Package manager for shell scripts"
  homepage "https://github.com/basherpm/basher"
  url "https://github.com/basherpm/basher.git",
    :revision => "dcf5c0dd9e033712fdac3da2bfdfeb430f13d16a"
  version "2019.11.29"

  def install
    Dir["*"].each do |f|
      cp_r f, prefix/f.to_s
    end

    # Dir[".*"].each do |f|
    #   cp_r f, prefix/"#{f}"
    # end

    bash_completion.install "completions/basher.bash"
    zsh_completion.install "completions/basher.zsh"
  end

  def caveats
    text = <<~EOS
      To make basher work smoothly, link it to your home directory
        ln -s /usr/local/opt/basher ~/.basher

      Add `basher init` to your shell to enable basher runtime functions
        echo 'eval "$(basher init -)"' >> ~/.bash_profile

      For Fish, use the following line on your ~/.config/fish/config.fish.
        status --is-interactive; and . (basher init -|psub)
    EOS
    text
  end

  test do
    system bin/"basher", "commands"
  end
end
