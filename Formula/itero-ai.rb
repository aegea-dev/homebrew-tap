# Homebrew formula for itero-ai, the local model's server itero starts:
# installs the release archives (made by `make dist-ai`, checked by their
# SHA-256), not a build from source. Its own formula, so a user with no
# model never downloads llama.cpp. The release workflow's tap job writes
# the version and the four checksums into the tap's copy; the zeros here
# are placeholders for that.
class IteroAi < Formula
  desc "Runs a local model for itero, behind the OpenAI API on a Unix socket"
  homepage "https://github.com/aegea-dev/itero"
  version "0.41.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3586b4b1a986b18a0be6ced953252e0adbd99fac9f3dfb5617b4c09e03bfb253"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "57674a7a560ee0c62312e51ee3506941c34f30d9992fdca50537feaace3bdb9c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9125e8acecd000d2a678eb607d137536899338edf0ae077ffedde4892a85d71"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ce275b1ae0d8830a10a200a8e69c90c14eb51e65ce6044da51671b72785bdfe2"
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
