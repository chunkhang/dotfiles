# Dotfiles
> All my precious dotfiles managed using [Dotbot](https://github.com/anishathalye/dotbot)

## Installing

Install `.dotfiles` folder:

```
git clone --recursive git@github.com:chunkhang/dotfiles.git ~/.dotfiles
```

Setup symlinks for all dotfiles:

```
~/.dotfiles/install
```

Setup `.zlocal` to apply local configuration as needed. For example,
setting up secrets that should not be commited:

```
echo "export CIRCLE_TOKEN=example" > ~/.zlocal
```

Install other tools such as neovim, tmux, etc as required.

## Usage

To add a new dotfile, create the file in `.dotfiles` folder:

```
touch ~/.dotfiles/vimrc
```

Update the `install.conf.yaml` with the new link:

```yaml
- link:
    ~/.vimrc:
```

Create the new symlink:

```
~/.dotfiles/install
```
