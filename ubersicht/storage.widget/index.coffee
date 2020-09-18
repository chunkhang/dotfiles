# You may exclude certain drives (separate with a pipe)
# Example: exclude = 'MyBook' or exclude = 'MyBook|WD Passport'
exclude   = 'VM|Recovery|Macintosh HD$'

# Use base 10 numbers, i.e. 1GB = 1000MB. Leave this true to show disk sizes as
# OS X would (since Snow Leopard)
base10       = true

# You may optionally limit the number of disk to show
maxDisks: 10

command: "df -#{if base10 then 'H' else 'h'} | grep '/dev/' | while read -r line; do fs=$(echo $line | awk '{print $1}'); name=$(diskutil info $fs | grep 'Volume Name' | awk '{print substr($0, index($0,$3))}'); echo $(echo $line | awk '{print $2, $3, $4, $5}') $(echo $name | awk '{print substr($0, index($0,$1))}'); done | grep -vE '#{exclude}'"

refreshFrequency: "30s"

style: """
  white = #e6e6e6
  red = #a64348

  // Change bar height
  bar-height = 2px

  // Align contents left or right
  widget-align = right

  // Position this where you want
  top: 260px
  right: 15px

  // Statistics text settings
  color: white
  font-family: Helvetica Neue

  user-select: none
  cursor: default

  .container
    width: 300px
    text-align: widget-align
    position: relative
    clear: both

  .container:not(:first-child)
    margin-top: 20px

  .widget-title
    text-align: widget-align
    margin-bottom: 2px

  .stats-container
    margin-bottom: 5px
    border-collapse: collapse

  table
    width: 50%
    margin-left: auto

  td
    font-size: 13px
    font-weight: 300
    text-align: widget-align

  td.pctg
    float: right

  .widget-title, p
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
    float: widget-align
    clear: both
    background: gray
    position: absolute
    margin-bottom: 5px

  .bar
    height: bar-height
    float: left
    transition: width .2s ease-in-out

  .bar-used
    background: red
"""

humanize: (sizeString) ->
  sizeString + 'B'


renderInfo: (total, used, free, pctg, name) -> """
  <div class="container">
    <div class="widget-title">#{name} #{@humanize(total)}</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class="stat"><span class="used">#{@humanize(used)}</span></td>
        <td class="stat"><span class="free">#{@humanize(free)}</span></td>
        <td class="stat pctg"><span class="pctg">#{pctg}</span></td>
      </tr>
      <tr>
        <td class="label">used</td>
        <td class="label">free</td>
        <td class="label pctg">full</td>
      </tr>
    </table>
    <div class="bar-container">
      <div class="bar bar-used" style="width: #{pctg}"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  disks = output.split('\n')
  $(domEl).html ''

  for disk, i in disks[..(@maxDisks - 1)]
    args = disk.split(' ')
    if (args[4])
      args[4] = args[4..].join(' ')
      $(domEl).append @renderInfo(args...)

  $(domEl).append ''
