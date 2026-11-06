# Homebrew formula for itero: installs the release archives (made by
# `make dist`, checked by their SHA-256), not a build from source. The
# release workflow's tap job writes the version and the four checksums into
# the tap's copy; the zeros here are placeholders for that.
class Itero < Formula
  desc "Runs workflows again and again: schedules, events, steps, workers"
  homepage "https://github.com/aegea-dev/itero"
  version "0.33.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "7cabda9ee300531bafa23cace39708bc1811c93221f6dcb6597a8ff198a1ba37"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "517352c6a6d074f66ab5043594ff257ab0c190f83e95acf618be9c5575d9b8bf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "676ffb616a9706b496c05dfb123f7b6c53ab6d999e5ba2f20f549c6fa2426439"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7ec3c984186e551a7c0d588cb02e1a4055f27412a8aa480629a125f8f151c859"
    end
  end

  def install
    bin.install "itero"
    prefix.install "THIRD-PARTY-LICENSES"
    libexec.install "Itero.app" if OS.mac?
  end

  def caveats
    <<~EOS
      Start the machine's daemon at login, for the workspaces on its list:
        itero workspace add      (in each workspace)
        itero service install

      After an upgrade, run the new itero:
        itero service restart

      On macOS, notifications come from itero (Itero.app, in this formula's
      libexec); macOS asks once to allow them.
    EOS
  end

  test do
    assert_match "itero #{version}", shell_output("#{bin}/itero --version")
  end
end
