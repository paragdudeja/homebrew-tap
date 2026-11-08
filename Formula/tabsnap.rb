class Tabsnap < Formula
  desc "Snapshot open browser tabs to markdown, with optional AI triage"
  homepage "https://github.com/paragdudeja/tabsnap"
  url "https://github.com/paragdudeja/tabsnap/archive/refs/tags/v0.2.6.tar.gz"
  sha256 "3d02ecbfc1fb6dd7020a177c61092d465cfe8d85935a3c3fc8a91a19baeed2d3"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    bin.install "tabsnap", "tabsnap-triage", "tabsnap-restore", "tabsnap-setup", "tabsnap-search"
    pkgshare.install "swiftbar", "skills"
  end

  def caveats
    <<~EOS
      Finish setting up (browser access, menu bar counter, Claude Code skill):
        tabsnap setup
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tabsnap --version")
    (testpath/"snap.md").write <<~EOS
      ## Safari — 2 tabs

      - [ ] [Open me](https://example.com/a)
      - [x] [Already done](https://example.com/b)
    EOS
    output = shell_output("#{bin}/tabsnap restore --dry-run #{testpath}/snap.md")
    assert_match "Would reopen 1 tabs", output
    assert_match "[Safari] https://example.com/a", output
    (testpath/"config").write "warn = 12\n"
    assert_match "warn  = 12", shell_output("TABSNAP_CONFIG=#{testpath}/config #{bin}/tabsnap config")
    (testpath/"snaps").mkpath
    cp testpath/"snap.md", testpath/"snaps/tabs_2026-01-01_00-00-00.md"
    assert_match "example.com/a", shell_output("TABSNAP_DIR=#{testpath}/snaps #{bin}/tabsnap search open me")
    assert_path_exists pkgshare/"skills/tabsnap/SKILL.md"
  end
end
