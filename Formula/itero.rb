# Homebrew formula for itero: installs the release archives (made by
# `make dist`, checked by their SHA-256), not a build from source. The
# release workflow's tap job writes the version and the four checksums into
# the tap's copy; the zeros here are placeholders for that.
class Itero < Formula
  desc "Runs workflows again and again: schedules, events, steps, workers"
  homepage "https://github.com/aegea-dev/itero"
  version "0.6.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f6ceeb3f93ea514f817e6b9e39e7f83429a58c884e6038a5eb997d1b7470cac0"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0e1a062af77aec38fe769bc1ad3055bc75713745a5580079d117b63f3aa55d24"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "44ce1d7a35f28ed3f631637b0317b0a855ca0f9684e22307873ee7ff243b5f00"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "98d0aa08763eec5ef5cc9c5537d0ad256e64ed583a9eaadff75e0f240be2b739"
    end
  end

  def install
    bin.install "itero"
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
