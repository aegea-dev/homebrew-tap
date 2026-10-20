# Homebrew formula for primum, written by primum's release workflow.
#
# Ships the prebuilt binaries from the GitHub release; each was run on a
# clean machine before the release was published.
class Primum < Formula
  desc "Prioritized work items as plain markdown files, with a CLI and a local web board"
  homepage "https://github.com/aegea-dev/primum"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "13075ee2dae2c09908d0af467bd75b5915acacaa826d8f7e6a14189518ab1abf"
    end
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d016e9f0e935fb668420a67a26a4f5e1622b1d0f095121fa4778a30c812f08bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e94e3bd78d4ffb7fcd4512af037fcb33f0c7e5364759bb0c653315643b212e30"
    end
    on_arm do
      url "https://github.com/aegea-dev/primum/releases/download/v#{version}/primum-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df8fe6ff44ce65ed77017e7332d338ec501a638f7a2a5a96d0f60a1d180ccbae"
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
