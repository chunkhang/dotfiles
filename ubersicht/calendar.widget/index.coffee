dayNames: ["S", "M", "T", "W", "T", "F", "S"]
monthNames: [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
]
offdays: [0]
displayedDate: null

command: "echo Hello World"

refreshFrequency: "1m"

style: """
  white = #e6e6e6
  red = #ff7777
  blue = #28afe5

  color: white
  font-family: Helvetica Neue
  font-size: 12px
  font-weight: 500
  bottom: 25px
  left: 50%
  transform: translate(-50%, 0)

  .calendar
    width: 750px

  .title
    margin-bottom: 10px
    text-align: center
    text-transform: uppercase

  table
    border-collapse: collapse
    font-size: 11px
    width: inherit
    table-layout: fixed
  td
    text-align: center

  .day td
    padding-bottom: 3px
  .line
    border-top: 0.5px solid white
  .date td
    padding-top: 2px
    font-weight: 400

  .day .offday,
  .date .offday,
  .day .off-today
    color: red
  .line .offday,
  .line .off-today
    border-top: 0.5px solid red

  .day .today,
  .date .today,
  .date .off-today
    color: blue
  .line .today
    border-top: 0.5px solid blue
"""

render: (_) -> """
  <div class="calendar">
    <div class="title"></div>
    <table>
      <tr class="day"></tr>
      <tr class="line"></tr>
      <tr class="date"></tr>
    </table>
  </div>
"""

update: (_, domEl) ->
  # Get today's date
  now = new Date()
  d = now.getDate()
  m = now.getMonth()
  y = now.getFullYear()
  todayDate = [d, m, y].join("/")

  # Do not manipulate DOM if it is still today
  if this.displayedDate isnt null and this.displayedDate is todayDate
    return
  this.displayedDate = todayDate
  dom = $(domEl)

  # Construct table cells
  firstDayOfMonth = new Date(y, m , 1).getDay()
  lastDateOfMonth = new Date(y, m + 1, 0).getDate()
  weekdays = ""
  midlines = ""
  dates = ""
  day = firstDayOfMonth
  for date in [1..lastDateOfMonth]
    day %= 7

    isToday = date is d
    isOffday = this.offdays.indexOf(day) isnt -1

    className = "normal"
    if isToday and isOffday
      className = "off-today"
    else if isToday
      className = "today"
    else if isOffday
      className = "offday"

    weekdays += "<td class='#{className}'>#{this.dayNames[day]}</td>"
    midlines += "<td class='#{className}'></td>"
    dates += "<td class='#{className}'>#{date}</td>"

    day++

  # Update DOM
  dom.find(".title").html "#{this.monthNames[m]} #{y}"
  dom.find(".day").html weekdays
  dom.find(".line").html midlines
  dom.find(".date").html dates
