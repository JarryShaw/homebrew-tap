class MacdailyToolkit < Formula
  desc "MacDaily Utility Tool Kit"
  homepage "https://github.com/JarryShaw/MacDaily/blob/master/doc/launch.rst#programs"

  depends_on "jarryshaw/tap/askpass"
  depends_on "jarryshaw/tap/confirm"

  test do
    system bin/"askpass", "--help"
    system bin/"confirm", "--help"
  end
end
