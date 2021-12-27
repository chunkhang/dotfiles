# Dotfiles
> All my precious dotfiles managed using [Dotbot](https://github.com/anishathalye/dotbot)

## Installing

Install `.dotfiles` folder:

```bash
git clone --recursive https://github.com/chunkhang/dotfiles ~/.dotfiles
```

Setup symlinks for all dotfiles:

```bash
~/.dotfiles/install
```

Setup `.zlocal` to apply local configuration as needed. For example,
setting up secrets that should not be commited:

```bash
echo "export CIRCLE_TOKEN=example" > ~/.zlocal
```

Install other tools such as neovim, tmux, etc as required.

## Usage

To add a new dotfile, create the file in `.dotfiles` folder:

```bash
touch ~/.dotfiles/vimrc
```

Update the `install.conf.yaml` with the new link:

```yaml
- link:
  ~/.vimrc:
```

Create the new symlink:

```bash
~/.dotfiles/install
```
