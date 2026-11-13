# my setup

Nothing fancy just some dev tools i like to use

## Homebrew

- `Brewfile`: tracked Homebrew taps, formulae, and casks.
- Restore on a new machine: `brew bundle --file=Brewfile`
- `sync-brew.sh`: dumps the current Homebrew setup to `Brewfile`, commits any changes under `nabeelzewail@gmail.com`, and pushes to `origin` (automatically triggered via `~/Library/LaunchAgents/com.nzewail.brewfile-sync.plist`).
