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
  version "0.64.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3f923b14bdea3bd6197f02947195a123423f9ba1779d5afacbf3aeb5bbdf0c80"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a331929568a83a384882199e0646c3a7a18788d6d02440cc9d73332d39da39c0"
    end
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "24dac2ad874ae089f85ed701bf073e1e7a00dbdfc96c786b8178200f47cb1cc6"
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
