# Homebrew Tap for Jarry Shaw's Productions

## Usage

Use the following commands to add this tap to your local Homebrew installation.

```shell
$ brew tap jarryshaw/tap
$ brew tap-pin jarryshaw/tap
$ brew install macdaily
```

The [`tap-pin` command](https://docs.brew.sh/Taps#formula-duplicate-names)
is necessary since mas is already included in the core tap of Homebrew. A pinned tap's
formulae take precedence over duplicates in other taps.

You can review the repos you have tapped and pinned using the following commands.

```shell
$ brew tap
caskroom/cask
jarryshaw/tap
$ brew tap --list-pinned
jarryshaw/tap
```

If you want to switch back to the core mas formula, you can unpin this tap.

```shell
$ brew tap-unpin jarryshaw/tap
```

## License

This repo is licensed under the MIT License. See the [LICENSE](LICENSE) file for rights and limitations.
