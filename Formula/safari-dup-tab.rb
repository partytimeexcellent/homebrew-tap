class SafariDupTab < Formula
  desc "Make Cmd+T in Safari duplicate the current tab, right next to it"
  homepage "https://github.com/partytimeexcellent/safari-dup-tab"
  url "https://github.com/partytimeexcellent/safari-dup-tab/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "f0d10e103bcfb2c3cf3e6c84e68f626ab78b739319da289cd5d87c1a0155912b"
  license "MIT"

  depends_on :macos

  def install
    system "./build.sh"
    prefix.install "build/SafariDupTab.app"
  end

  service do
    run opt_prefix/"SafariDupTab.app/Contents/MacOS/SafariDupTab"
    keep_alive true
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
