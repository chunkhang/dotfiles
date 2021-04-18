command: "network.widget/lib/network.sh"

refreshFrequency: "5s"

style: """
    white = #e6e6e6
    red = #a64348
    blue = #4c9ec0
    gray = #7f7f7f

    // Change bar height
    bar-height = 2px

    // Position this where you want
    top: 125px
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

    table
        width: 50%

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
        transition: width .2s ease-in-out

    .bar:first-child
        float: left

    .bar:last-child
        float: right

    .bar-down
        background: red

    .bar-up
        background: blue
"""

render: -> """
    <div class="container">
        <div class="widget-title">Network</div>
        <table class="stats-container">
            <tr>
                <td class="stat"><span class="down"></span></td>
                <td class="stat"><span class="up"></span></td>
            </tr>
            <tr>
                <td class="label"><span class="label-down">down</span></td>
                <td class="label"><span class="label-up">up</span></td>
            </tr>
        </table>
        <div class="bar-container">
            <div class="bar bar-down"></div>
            <div class="bar bar-up"></div>
        </div>
    </div>
"""

update: (output, domEl) ->

    usage = (bytes) ->
        kb = bytes / 1024
        usageFormat kb

    usageFormat = (kb) ->
        if kb > 1024
            mb = kb / 1024
            "#{parseFloat(mb.toFixed(1))} MB/s"
        else
            "#{parseFloat(kb.toFixed(2))} KB/s"

    updateStat = (sel, currBytes, totalBytes) ->
        percent = (currBytes / totalBytes * 100).toFixed(1) + "%"
        $(domEl).find(".#{sel}").text usage(currBytes)
        $(domEl).find(".bar-#{sel}").css "width", percent

    args = output.split "^"

    downBytes = (Number) args[0]
    upBytes = (Number) args[1]

    totalBytes = downBytes + upBytes

    updateStat 'down', downBytes, totalBytes
    updateStat 'up', upBytes, totalBytes
