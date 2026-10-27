# Homebrew formula for itero: installs the release archives (made by
# `make dist`, checked by their SHA-256), not a build from source. The
# release workflow's tap job writes the version and the four checksums into
# the tap's copy; the zeros here are placeholders for that.
class Itero < Formula
  desc "Runs workflows again and again: schedules, events, steps, workers"
  homepage "https://github.com/aegea-dev/itero"
  version "0.14.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "92fd060ba7ba9bda3eacbc3227214f41627e15390907d50b728869902a02849a"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "575065549e57de6156aed7e97f386729ea90d21921ba1466f8c6a2db159bb0f0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "847f964344c24ffb46ed629ae7b7e5001481803e96a830376730c4fb3c78eb86"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bf993a9b6864af22aeb4cefa7accc8660eba122f108e8c09c7f0fe138a8dd104"
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
