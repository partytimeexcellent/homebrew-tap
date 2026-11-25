class SafariDupTab < Formula
  desc "Make Cmd+T in Safari duplicate the current tab, right next to it"
  homepage "https://github.com/partytimeexcellent/safari-dup-tab"
  url "https://github.com/partytimeexcellent/safari-dup-tab/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "209e5e774398ca6071666e0cef980a5e5293d22b83297fea217187cfab1a2d05"
  license "MIT"

  depends_on :macos

  def install
    system "./build.sh"
    prefix.install "build/SafariDupTab.app"
  end

  service do
    run opt_prefix/"SafariDupTab.app/Contents/MacOS/SafariDupTab"
    keep_alive true
    environment_variables SAFARIDUPTAB_LAUNCHD: "1"
    log_path var/"log/safari-dup-tab.log"
    error_log_path var/"log/safari-dup-tab.log"
  end

  def caveats
    <<~EOS
      Start it (and have it start at login):
        brew services start safari-dup-tab

      Then grant permission in System Settings → Privacy & Security →
      Device Control and Data Access (called Accessibility before macOS 27):
      turn on SafariDupTab, or click + and add:
        #{opt_prefix}/SafariDupTab.app

      The first time you press ⌘T in Safari, click Allow when asked whether
      SafariDupTab can control Safari.

      After upgrading or reinstalling, you may need to remove SafariDupTab
      from that list and add it again.
    EOS
  end

  test do
    assert_path_exists prefix/"SafariDupTab.app/Contents/MacOS/SafariDupTab"
  end
end
