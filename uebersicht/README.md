# Uebersicht

> [Uebersicht][uebersicht] widgets for the desktop

## Installation

Setup the code:

```
just setup
```

Then, set the [Uebersicht][uebersicht] widgets folder to this one.

## Development

### Linting

To lint the code with [Prettier][prettier] and [ESLint][eslint]:

```
just lint
```

To format the code with [Prettier][prettier]:

```
just format
```

To fix the code with [ESLint][eslint]:

```
just fix
```

### Icons

The list of icons installed can be found in `fontello/config.json`. To use them,
provide the correct CSS class name:

```
<i className="icon-bluetooth" />
```

To update the available icons, open the config in [Fontello][fontello] for
editing:

```
just open-fontello
```

Do the necessary updates, before clicking "Save session" in the browser. Now,
install the updated icons:

```
just install-fontello
```

The config file `fontello/config.json` should be updated accordingly.

[uebersicht]: https://github.com/felixhageloh/uebersicht
[fontello]: https://fontello.com/
[prettier]: https://prettier.io/
[eslint]: https://eslint.org/
