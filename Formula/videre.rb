# Homebrew formula for videre.
#
# Ships the prebuilt binaries from the GitHub release rather than building from
# source: a source build compiles candle and ONNX Runtime, which takes minutes
# to tens of minutes, and the released artifacts are already verified (each is
# downloaded onto a clean runner and actually executed before the release is
# published).
#
# No Intel macOS bottle. ONNX Runtime ships no prebuilt binaries for
# x86_64-apple-darwin, so videre cannot be built for that target at all.
class Videre < Formula
  desc "Local-first CLI for photo and video libraries: duplicates, search, faces"
  homepage "https://github.com/aegea-dev/videre"
  version "0.64.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "667dc1de3e98cd59073a07d62ed5f3f560f919069afef31b813aeba89069feb2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "60e1c05eb9cd9ed5e2ee69b5ae3a8373f7f493ead5a544fbddd310eca5396176"
    end
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6dd3bd8975972a94ef67c5379264e5f6e88796c8d0ddc21b9d11e9af830a8930"
    end
  end

  def install
    bin.install "videre"
  end

  def caveats
    <<~EOS
      Model weights are downloaded on first use, not at install:
        videre embed  ~1.5 GB (semantic search, also used by search and classify)
        videre faces  ~180 MB (face detection)

      scan, dedupe, fix-dates, prune, stats, status, locations, import,
      export, mark and tag need no model at all.
    EOS
  end

  test do
    assert_match "videre #{version}", shell_output("#{bin}/videre --version")
  end
end
