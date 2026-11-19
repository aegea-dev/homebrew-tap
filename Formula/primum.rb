# Homebrew formula for primum, written by primum's release workflow.
#
# Ships the prebuilt binaries from the GitHub release; each was run on a
# clean machine before the release was published.
class Primum < Formula
  desc "Prioritized work items as plain markdown files, with a CLI and a local web board"
  homepage "https://github.com/aegea-dev/primum"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "54fbf5090d41bd6f9414f50705182071ff6e0ccef436125e7c06f92fda8cd05a"
    end
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "48e460284e1bad6dbc1424353ac6f6b1fbcaf9499d3f8eb979b8890eef5cd547"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ea16ee7dc3df44e0dadae1165a1619d6a6170efdfb66f4e930da80d29c1a1f52"
    end
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ad3acdfdac106176ed5e0945eb82a85bf9abea719fbc154a555a77cbd1d7095"
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
