# macOS

## Improve font

```
defaults write -g AppleFontSmoothing -int 0
```

## Improve sleep

```
sudo pmset -a powernap 0
sudo pmset -a tcpkeepalive 0
sudo pmset -a ttyskeepawake 0
```

## Disable Spotlight

```
sudo mdutil -a -i off
```

## Disable accent keys

```
defaults write -g ApplePressAndHoldEnabled -bool false
```
