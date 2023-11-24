# st

## Fixing Crash from Rendering Emoji

https://www.reddit.com/r/archlinux/comments/byy647/st_sucklesssimple_terminal_and_emoji/

Install `ttf-symbola` font.

For Ubuntu:

```
sudo apt install fonts-symbola
fc-cache
```

To test:

```
echo ☹️
```
