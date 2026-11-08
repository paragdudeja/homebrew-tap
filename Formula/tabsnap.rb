class Tabsnap < Formula
  desc "Snapshot open browser tabs to markdown, with optional AI triage"
  homepage "https://github.com/paragdudeja/tabsnap"
  url "https://github.com/paragdudeja/tabsnap/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "af84fc6d6b3a0b1634241011907ef0d9a23ec976d7125b4e9144c9832a4b1d54"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    bin.install "tabsnap", "tabsnap-triage"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tabsnap --version")
    assert_match "ANTHROPIC_API_KEY", shell_output("env -u ANTHROPIC_API_KEY #{bin}/tabsnap triage 2>&1", 1)
  end
end
