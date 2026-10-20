# Homebrew formula for primum, written by primum's release workflow.
#
# Ships the prebuilt binaries from the GitHub release; each was run on a
# clean machine before the release was published.
class Primum < Formula
  desc "Prioritized work items as plain markdown files, with a CLI and a local web board"
  homepage "https://github.com/aegea-dev/primum"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "272eb68e9406ff94ff07a502efd51dfc545eb886ba903327e41a128058df42ec"
    end
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "78d567f2af299f92ebb4c3a224c0421cd3b77082c2d49ff377e3cc1fcd37b043"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb2ff3b191b66e6a2bbc8d13b09191a24d22df4a6700328bcbcb4f370b3de5e7"
    end
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0b1c42f1d94c0f87f56acd730a35a6d87a58bae1292f2d29956157fc9228b28a"
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
