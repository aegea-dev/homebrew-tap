# Homebrew formula for itero: installs the release archives (made by
# `make dist`, checked by their SHA-256), not a build from source. The
# release workflow's tap job writes the version and the four checksums into
# the tap's copy; the zeros here are placeholders for that.
class Itero < Formula
  desc "Runs workflows again and again: schedules, events, steps, workers"
  homepage "https://github.com/aegea-dev/itero"
  version "0.19.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a9809fb4e487a5302c8fd8135ecebd00bdfc778945f16ee7df3c4d804a49f8c9"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "72c734c871799c2ebe2400d2c2d21fbff61b96e4d34a985413d22cddacd35741"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "76145f4f885ec037c94b83d62f96f15748950a4347d7a4a7389d1af7794636c1"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b7d26e9f46423213a73fbe07a7fb4778622f5e604b5a9bc9c47341a770372eea"
    end
  end

  def install
    bin.install "itero"
    prefix.install "THIRD-PARTY-LICENSES"
    libexec.install "Itero.app" if OS.mac?
  end

  def caveats
    <<~EOS
      Start a workspace's daemon at login, in that workspace:
        itero service install

      On macOS, notifications come from itero (Itero.app, in this formula's
      libexec); macOS asks once to allow them.
    EOS
  end

  test do
    assert_match "itero #{version}", shell_output("#{bin}/itero --version")
  end
end
