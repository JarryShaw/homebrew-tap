# Homebrew Tap for Jarry Shaw's Productions

## Usage

Use the following commands to add this tap to your local Homebrew installation.

```bash
$ brew tap jarryshaw/tap
$ brew tap-pin jarryshaw/tap
# to install MacDaily
$ brew install macdaily
```

The [`tap-pin` command](https://docs.brew.sh/Taps#formula-duplicate-names)
is necessary since mas is already included in the core tap of Homebrew. A pinned tap's
formulae take precedence over duplicates in other taps.

You can review the repositories you have tapped and pinned using the following commands.

```bash
$ brew tap
caskroom/cask
jarryshaw/tap
$ brew tap --list-pinned
jarryshaw/tap
```

If you want to switch back to the core mas formula, you can unpin this tap.

```bash
$ brew tap-unpin jarryshaw/tap
```

## Formula

- [`MacDaily`](https://github.com/JarryShaw/MacDaily#macdaily)
- [`f2format`](https://github.com/JarryShaw/f2format#f2format)
- [`AskPass`](https://github.com/JarryShaw/askpass#askpass)
- [`Confirm`](https://github.com/JarryShaw/confirm#confirm)
- [`MacDaily-ToolKit`](https://github.com/JarryShaw/MacDaily/blob/master/doc/launch.rst#programs)

## License

This repo is licensed under the MIT License. See the [LICENSE](LICENSE) file for rights and limitations.

## Acknowledgement

This [README](README.md) file used [README.md](https://github.com/mas-cli/homebrew-tap/blob/master/README.md) of [`mas-cli/homebrew-tap`](https://github.com/mas-cli/homebrew-tap) for reference.
