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
  version "0.63.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "878423dc19a7b920d49ab512d345cfb0257f049b48f08f1176c92fba05fce703"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b9d9f64b3e4785a937c6544d57dd700ee91eb60977d4b43e7fbd8d3adfeb041"
    end
    on_arm do
      url "https://github.com/aegea-dev/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4dc0bcfc6921f9d81a359bd2bf2e26c08230f0beff97dd2cfa102c127ad78d45"
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
