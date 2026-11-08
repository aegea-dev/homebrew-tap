# Homebrew formula for itero-ai, the local model's server itero starts:
# installs the release archives (made by `make dist-ai`, checked by their
# SHA-256), not a build from source. Its own formula, so a user with no
# model never downloads llama.cpp. The release workflow's tap job writes
# the version and the four checksums into the tap's copy; the zeros here
# are placeholders for that.
class IteroAi < Formula
  desc "Runs a local model for itero, behind the OpenAI API on a Unix socket"
  homepage "https://github.com/aegea-dev/itero"
  version "0.36.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "a9e24e796725f73cea458d93d9b1f1fc1f71aa968518c8875a328f7a62934b62"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "786e90da6af2e119e19296a39487f3a24c0e79a4c7734bd66a740c9858e3d874"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f9cf62b4875f151f46d4162e5fb160cc1cabaf42580bdadc7b7358981482e03"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5cabecf0d117fc8159f562c9e859c5f68ff3b36f1b48ba677f9a0233f4a26241"
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
