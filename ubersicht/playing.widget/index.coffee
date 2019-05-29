options =
  # Enable or disable the widget.
  widgetEnable : true                   # true | false

  # Choose where the widget should sit on your screen.
  verticalPosition    : "top"        # top | bottom | center
  horizontalPosition    : "center"        # left | right | center

command: "osascript 'playing.widget/lib/Get Current Track.applescript'"
refreshFrequency: '1s'
style: """
white = #e6e6e6
gray = #7f7f7f

// setup
// --------------------------------------------------
display: none
font-family: Helvetica Neue
font-size: 10px
margin = 20px
position: absolute

// variables
// --------------------------------------------------
widgetWidth 300px
infoHeight 65px
infoWidth @widgetWidth - 82

// screen positioning calculations
// --------------------------------------------------
if #{options.verticalPosition} == center
    top 50%
    transform translateY(-50%)
else
    #{options.verticalPosition} margin

if #{options.horizontalPosition} == center
    left 50%
    transform translateX(-50%)
else
    #{options.horizontalPosition} margin

// styles
// --------------------------------------------------
.container
    width: @widgetWidth
    height: @infoHeight
    text-align: left
    position: relative
    clear: both
    color #fff

.album-art
    width: @infoHeight
    height: @width
    background-image: url(playing.widget/lib/default.png)
    background-size: cover
    float: left
    outline: 0.5px solid gray

.track-info
    width: @infoWidth
    height: @infoHeight
    margin-left: 10px
    position: relative
    float: left

.artist-name
    font-weight: 500
    margin-top: 5px
    margin-bottom: 3px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis
    text-transform: uppercase

.track-title
    font-weight: 300
    font-size: 13px
    margin-bottom: 0
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.album-title
    font-weight: 300
    font-size: 11px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.bar-container
    width: 100%
    height: 2px
    background: gray
    position: absolute
    bottom: 5px

.bar
    height: inherit
    transition: width .2s ease-in-out

.bar-progress
    background: white
"""

options : options

render: () -> """
<div class="container">
    <div class="album-art"></div>
    <div class="track-info">
        <div class="artist-name"></div>
        <div class="track-title">title</div>
        <div class="album-title"></div>
        <div class="bar-container">
            <div class="bar bar-progress"></div>
        </div>
        <div class="console">
        </div>
    </div>
</div>
"""

# Update the rendered output.
update: (output, domEl) ->

  div = $(domEl)

  if @options.widgetEnable

    if !output
      div.animate({opacity: 0}, 250, 'swing').hide(1)
    else
      values = output.slice(0,-1).split(" @ ")
      div.find('.artist-name').html(values[0])
      div.find('.track-title').html(values[1])
      div.find('.album-title').html(values[2])
      tDuration = values[3]
      tPosition = values[4]
      tArtwork = values[5]
      songChanged = values[6]
      currArt = "/" + div.find('.album-art').css('background-image').split('/').slice(-3).join().replace(/\,/g, '/').slice(0,-1)
      tWidth = 218
      tCurrent = (tPosition / tDuration) * tWidth
      div.find('.bar-progress').css width: tCurrent
      div.show(1).animate({opacity: 1}, 250, 'swing')

      if currArt isnt tArtwork and tArtwork isnt 'NA'
        artwork = div.find('.album-art')
        artwork.css('background-image', 'url('+tArtwork+')')
      else if tArtwork is 'NA'
        artwork = div.find('.album-art')
        artwork.css('background-image', 'url(playing.widget/lib/default.png)')
  else
    div.hide()
