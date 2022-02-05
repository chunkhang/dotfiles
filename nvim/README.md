# Neovim

> [Neovim][neovim] configuration files

## Dependencies

Make sure the following dependencies are installed:

- [Node][node]
- [Python][python]
- [Poetry][poetry]
- [Ctags][ctags]
- [ripgrep][ripgrep]
- [par][par]
- [jq][jq]

## Installing

Setup the code:

```
just setup
```

## Development

### Linting

To lint the code with [Vint][vint]:

```
just lint
```

[neovim]: https://neovim.io/
[node]: https://nodejs.org/en/
[python]: https://www.python.org/
[poetry]: https://python-poetry.org/
[ctags]: https://ctags.io/
[ripgrep]: https://github.com/BurntSushi/ripgrep
[par]: http://www.nicemice.net/par/
[jq]: https://stedolan.github.io/jq/
[vint]: https://github.com/Vimjas/vint
