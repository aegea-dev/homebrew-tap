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
  version "0.64.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "7a0a66795ec092c6a5975ed2d3d08fb7ab51641ace6800f7185feb7142741771"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d6f39e30bef5c03baf759d168d8bbaf0ca0ebdae190525682c73475b58cde825"
    end
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "60c30270e8612c54d398e9b1351781013dc30cddfe15daff7e905804335ec36d"
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
