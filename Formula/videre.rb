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
  version "0.64.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "cc8a74ebec4724a77341c177779f617e7e04eb8c38f0c1ef9055c5ad6c180424"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "90da4aaa5d214a882babc7499deb08474d3c4c7ac578f97ea98e6b688db5b110"
    end
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "992780a95b9b4cc5987b607364493430a748a75f63d572d5a624b7bc7e3dbd29"
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
