# Homebrew formula for itero-ai, the local model's server itero starts:
# installs the release archives (made by `make dist-ai`, checked by their
# SHA-256), not a build from source. Its own formula, so a user with no
# model never downloads llama.cpp. The release workflow's tap job writes
# the version and the four checksums into the tap's copy; the zeros here
# are placeholders for that.
class IteroAi < Formula
  desc "Runs a local model for itero, behind the OpenAI API on a Unix socket"
  homepage "https://github.com/aegea-dev/itero"
  version "0.48.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "ebfa664f89a499174a5045904c302bea4fdf94e99634d9303c8c0913e883fe49"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "ce60270faae2aa9c485db8f036486973fdab8276eff7f55371d2984059baac32"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f696d08b63dd8d2a4cccd4732e43596b19263b91b0a95789e1d1c91bb24409a6"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6487e7fc2984d98d23936ff6ef101f4665e92726af5f215e537e39986c6acfea"
    end
  end

  def install
    bin.install "itero-ai"
    prefix.install "THIRD-PARTY-LICENSES"
  end

  def caveats
    <<~EOS
      itero starts itero-ai when a workflow's #ai step needs it; it is not
      run by hand. itero ai models list shows the models it can use.
    EOS
  end

  test do
    # with nothing in its environment it says what it needs
    output = shell_output("#{bin}/itero-ai 2>&1", 2)
    assert_match "ITERO_AI_IDLE is not set", output
  end
end
