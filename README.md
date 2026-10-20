# homebrew-tap

Homebrew formulae for [videre](https://github.com/aegea-dev/videre), a
local-first CLI for photo and video libraries.

```bash
brew install aegea-dev/tap/videre
```

Installed from the old `erhangundogan/tap`? Move to this one:

```bash
brew uninstall videre
brew untap erhangundogan/tap
brew install aegea-dev/tap/videre
```

## Why a tap rather than homebrew-core

homebrew-core has notability requirements videre does not yet meet. A tap works
identically for users; the only difference is the qualified name above.

## What gets installed

The prebuilt binary from the matching GitHub release, not a source build. A
source build compiles candle and ONNX Runtime, which takes minutes to tens of
minutes. Every released artifact is downloaded onto a clean machine and
actually executed before the release is published.

Supported: Apple Silicon macOS, Linux x86_64, Linux ARM64.

Not supported: Intel macOS. ONNX Runtime ships no prebuilt binaries for
`x86_64-apple-darwin`, so videre cannot be built for that target at all,
including via `cargo install`.

## Updating

`Formula/videre.rb` carries a version and three checksums. Keeping it current
matters more than it looks: a tap that lags does not fail, it silently installs
an old version.
