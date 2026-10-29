# Homebrew formula for itero: installs the release archives (made by
# `make dist`, checked by their SHA-256), not a build from source. The
# release workflow's tap job writes the version and the four checksums into
# the tap's copy; the zeros here are placeholders for that.
class Itero < Formula
  desc "Runs workflows again and again: schedules, events, steps, workers"
  homepage "https://github.com/aegea-dev/itero"
  version "0.18.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "55517ba59d0b6fd8470c3d7fbebf1bded8607fe987c415de18bfb30c537a948a"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "20b5cd030502f65a510565fd1d6ade5f7aa461b5bb23ae7d65ff4ebfe3cf4c45"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cf381debe8c46de9aafbbf9dcb3fa1c5c7ec301430d3976eb034dd9b21146cd5"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e3e4c7e4c27be65c708b01d9849cf9e45d61084a85244cbbaa2c85d738f8b1d7"
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
