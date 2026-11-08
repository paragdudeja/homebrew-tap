class Tabsnap < Formula
  desc "Snapshot open browser tabs to markdown, with optional AI triage"
  homepage "https://github.com/paragdudeja/tabsnap"
  url "https://github.com/paragdudeja/tabsnap/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "91a2a4c924d579a79cb36db18e5ecea41231e180f8c1e63aa80fe60dfb43e2d1"
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
