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
  homepage "https://github.com/erhangundogan/videre"
  version "0.62.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a0c3d85fb551fdf25266c50c8fb4ebd45534e913984b353a57af4d56fb660613"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4e8ffe76593bad1e18ecb31c34e07d6b4d63aec6a1b534b008898eafa217eb4e"
    end
    on_arm do
      url "https://github.com/erhangundogan/videre/releases/download/v#{version}/videre-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e8a3045aff695491b9ae802f52374cd26abe4b2d354e0c9be2dc742618cced13"
    end
  end

  def install
    bin.install "videre"
  end

  def caveats
    <<~EOS
      Model weights are downloaded on first use, not at install:
        videre embed  ~780 MB (semantic search)
        videre faces  ~180 MB (face detection)

      scan, dedupe, fix-dates, prune, stats and locations need no model at all.
    EOS
  end

  test do
    assert_match "videre #{version}", shell_output("#{bin}/videre --version")
  end
end
