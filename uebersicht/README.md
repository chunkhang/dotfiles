# Uebersicht

> [Uebersicht][uebersicht] widgets for the desktop

## Installation

Setup the code:

```
just setup
```

Then, set the [Uebersicht][uebersicht] widgets folder to this one.

## Development

### Icons

The list of icons installed can be found in `lib/fontello/config.json`. To use
them, provide the correct CSS class name:

```
<i className="icon-bluetooth" />
```

To update the available icons, open the config in [Fontello][fontello] for
editing:

```
just fontello open
```

Download the new config file to replace the existing `lib/fontello/config.json`,
and install the new icons:

```
just fontello install
```

### Linting

To lint the code with [Prettier][prettier] and [ESLint][eslint]:

```
just lint
```

### Formatting

To format the code with [Prettier][prettier]:

```
just format
```

### Fixing

To fix the code with [ESLint][eslint]:

```
just fix
```

[uebersicht]: https://github.com/felixhageloh/uebersicht
[fontello]: https://fontello.com/
[prettier]: https://prettier.io/
[eslint]: https://eslint.org/
