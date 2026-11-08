class Tabsnap < Formula
  desc "Snapshot open browser tabs to markdown, with optional AI triage"
  homepage "https://github.com/paragdudeja/tabsnap"
  url "https://github.com/paragdudeja/tabsnap/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "e558754190eab9cafa8bb7fc3ebe34a12a35649302c819db828c7dd444ef0795"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    bin.install "tabsnap", "tabsnap-triage", "tabsnap-restore"
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
  end
end
