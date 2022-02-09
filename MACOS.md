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

```
launchctl unload -w /System/Library/LaunchAgents/com.apple.AddressBook.SourceSync.plist
```

## Disable accent keys

```
defaults write -g ApplePressAndHoldEnabled -bool false
```
