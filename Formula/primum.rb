# Homebrew formula for primum, written by primum's release workflow.
#
# Ships the prebuilt binaries from the GitHub release; each was run on a
# clean machine before the release was published.
class Primum < Formula
  desc "Prioritized work items as plain markdown files, with a CLI and a local web board"
  homepage "https://github.com/aegea-dev/primum"
  version "0.2.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "5cb69bf5f4a261b7de82b124905453918defcc72ae19c7b9ffa8d4160777ad1c"
    end
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "df06f9627c594d19a3821b19d5da8efad4cac9222d7987ecdcce87dd66ff2460"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b80860b82671e5b81cc3bb4484cb471cab52ac39ca4b87800eda132379125e2d"
    end
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92d94690d584b853ddaa8e42795c641d4e1172e324305a8e4ca3a98ff9c4ba56"
    end
  end

  def install
    bin.install "primum"
  end

  def caveats
    <<~EOS
      primum serve opens the board in your browser.
    EOS
  end

  test do
    assert_match "primum #{version}", shell_output("#{bin}/primum --version")
  end
end
