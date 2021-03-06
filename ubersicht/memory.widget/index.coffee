command: "memory_pressure && sysctl -n hw.memsize"

refreshFrequency: "5s"

style: """
  white = #abb2bf
  red = #e06c75
  blue = #61afef
  yellow = #e4bf7f
  gray = #3e4452

  // Change bar height
  bar-height = 2px

  // Position this where you want
  top: 190px
  left: 15px

  // Statistics text settings
  color: white
  font-family: Helvetica Neue

  user-select: none
  cursor: default

  .container
    width: 300px
    position: relative
    clear: both

  .widget-title
    margin-bottom: 2px

  .stats-container
    margin-bottom: 5px
    border-collapse: collapse

  td
    font-size: 13px
    font-weight: 300

  .widget-title
    font-size: 10px
    text-transform: uppercase
    font-weight: 500

  .label
    font-size: 8px
    text-transform: uppercase
    font-weight: 500

  .bar-container
    width: 100%
    height: bar-height
    clear: both
    background: gray
    position: absolute
    margin-bottom: 5px

  .bar
    height: bar-height
    float: left
    transition: width .2s ease-in-out

  .bar-inactive
    background: blue

  .bar-active
    background: yellow

  .bar-wired
    background: red
"""


render: -> """
  <div class="container">
    <div class="widget-title">Memory</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class="stat"><span class="wired"></span></td>
        <td class="stat"><span class="active"></span></td>
        <td class="stat"><span class="inactive"></span></td>
        <td class="stat"><span class="free"></span></td>
        <td class="stat"><span class="total"></span></td>
      </tr>
      <tr>
        <td class="label">wired</td>
        <td class="label">active</td>
        <td class="label">inactive</td>
        <td class="label">free</td>
        <td class="label">total</td>
      </tr>
    </table>
    <div class="bar-container">
      <div class="bar bar-wired"></div>
      <div class="bar bar-active"></div>
      <div class="bar bar-inactive"></div>
    </div>
  </div>
"""

update: (output, domEl) ->

  usage = (pages) ->
    mb = (pages * 4096) / 1024 / 1024
    usageFormat mb

  usageFormat = (mb) ->
    if mb > 1024
      gb = mb / 1024
      "#{parseFloat(gb.toFixed(2))}GB"
    else
      "#{parseFloat(mb.toFixed())}MB"

  updateStat = (sel, usedPages, totalBytes) ->
    usedBytes = usedPages * 4096
    percent = (usedBytes / totalBytes * 100).toFixed(1) + "%"
    $(domEl).find(".#{sel}").text usage(usedPages)
    $(domEl).find(".bar-#{sel}").css "width", percent

  lines = output.split "\n"

  freePages = lines[3].split(": ")[1]
  inactivePages = lines[13].split(": ")[1]
  activePages = lines[12].split(": ")[1]
  wiredPages = lines[16].split(": ")[1]

  totalBytes = lines[28]
  $(domEl).find(".total").text usageFormat(totalBytes / 1024 / 1024)

  updateStat 'free', freePages, totalBytes
  updateStat 'active', activePages, totalBytes
  updateStat 'inactive', inactivePages, totalBytes
  updateStat 'wired', wiredPages, totalBytes
