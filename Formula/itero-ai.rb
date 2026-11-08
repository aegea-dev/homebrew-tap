# Homebrew formula for itero-ai, the local model's server itero starts:
# installs the release archives (made by `make dist-ai`, checked by their
# SHA-256), not a build from source. Its own formula, so a user with no
# model never downloads llama.cpp. The release workflow's tap job writes
# the version and the four checksums into the tap's copy; the zeros here
# are placeholders for that.
class IteroAi < Formula
  desc "Runs a local model for itero, behind the OpenAI API on a Unix socket"
  homepage "https://github.com/aegea-dev/itero"
  version "0.35.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "d13bc9f7e8ebe706dd9d46102aa9ff9490c66c3f78a8dea81abc91cabd8fa7c3"
    end
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0a297f6e0bffdd0153bdf034eef0aa04d65e0ed2bb002129a6befc20624df3a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cae00c5da7d075c2213b7d06a89e4013fec517e17d1ce2bffe9305010274aaf3"
    end
    on_arm do
      url "https://github.com/aegea-dev/itero/releases/download/v#{version}/itero-ai-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "53988cd28aeb6001e28ce33e7aac4409b49ac503f4640cb11827c8b68ef23f07"
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
