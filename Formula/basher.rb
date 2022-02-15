class Basher < Formula
  desc "Package manager for shell scripts"
  homepage "https://github.com/basherpm/basher"
  url "https://github.com/basherpm/basher.git",
    revision: "d53eb7b6444b72669fdd4b861f2853f22ff0f2d0"
  version "2022.2.15"

  depends_on "homebrew/core/bash"
  depends_on "homebrew/core/coreutils"

  def install
    ENV["BASHER_ROOT"] = "#{prefix}"

    inreplace libexec/"basher", "$HOME/.basher", "#{prefix}"
    inreplace libexec/"basher", "$BASHER_ROOT/cellar", "#{HOMEBREW_PREFIX}/lib/basher/cellar"

    Dir["*"].each do |f|
      cp_r f, prefix/f.to_s
    end

    (bash_completion/"basher").write `#{bin}/basher init - bash`
    (fish_completion/"basher").write `#{bin}/basher init - fish|psub`
    (zsh_completion/"basher").write `#{bin}/basher init - zsh`
  end

  def caveats
    <<~EOS
      To make basher work smoothly, link it to your home directory
        ln -s #{opt_prefix} ~/.basher

      Or add the following environment variable as
        BASHER_ROOT=#{opt_prefix}
    EOS
  end

  test do
    system bin/"basher", "commands"
  end
end
