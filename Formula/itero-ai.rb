# Homebrew formula for itero-ai, the local model's server itero starts:
# installs the release archives (made by `make dist-ai`, checked by their
# SHA-256), not a build from source. Its own formula, so a user with no
# model never downloads llama.cpp. The release workflow's tap job writes
# the version and the four checksums into the tap's copy; the zeros here
# are placeholders for that.
class IteroAi < Formula
  desc "Runs a local model for itero, behind the OpenAI API on a Unix socket"
  homepage "https://github.com/aegea-dev/itero"
  version "0.29.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "9c41d951711770f007ccf94f2e74bb1d583edcc53413b26f33a09d01222558dc"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "a8c9bc60ee815d732c2f4fe963adfe39c2e7b4b3543514838289b479242acc17"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b0c21cf35a2a20134c60552bf8bd83b5f749184ca7a5d21a329bd3c1a57d7ad"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b7ea36cc6830cc723b23ef598ccba88c521de00a936b2251a3ffdb249f05e86"
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
