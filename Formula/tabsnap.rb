class Tabsnap < Formula
  desc "Snapshot open browser tabs to markdown, with optional AI triage"
  homepage "https://github.com/paragdudeja/tabsnap"
  url "https://github.com/paragdudeja/tabsnap/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e90460c743512f4362fa3549111516c617edb55b8f616a36ba14dd2a986c440d"
  license "MIT"

  depends_on "jq"
  depends_on :macos

  def install
    bin.install "tabsnap", "tabsnap-triage", "tabsnap-restore"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tabsnap --version")
    assert_match "ANTHROPIC_API_KEY", shell_output("env -u ANTHROPIC_API_KEY #{bin}/tabsnap triage 2>&1", 1)
  end
end
