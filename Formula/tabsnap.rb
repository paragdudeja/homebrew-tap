class Tabsnap < Formula
  desc "Snapshot open browser tabs to markdown, with optional AI triage"
  homepage "https://github.com/paragdudeja/tabsnap"
  url "https://github.com/paragdudeja/tabsnap/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "395761733d549b3e9c990a34317b3b2eb9d266e65bc81f2dbe937deb5fd2fb70"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    bin.install "tabsnap", "tabsnap-triage", "tabsnap-restore", "tabsnap-setup"
    pkgshare.install "swiftbar"
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
  end
end
