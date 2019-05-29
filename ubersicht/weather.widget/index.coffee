# Configuration
apiKey: "7d65a654ef0ea7de4929fdd1d97b3f83"

command: "echo weather"

refreshFrequency: "10m"

style: """
  white = #e6e6e6

  color: white
  font-family: Helvetica Neue
  font-size: 12px
  font-weight: 300
  top: 75px
  left: 20px
  width: 300px

  .title
    font-size: 10px
    text-transform: uppercase
    font-weight: 500
    margin-bottom: 2px

  .error
    font-size: 13px

  .weather
    display: flex
    margin-top: 2px

  .icon
    font-size: 22px
    font-style: normal
    margin-right: 2px

  .info
    margin-top: 3px
    line-height: 1

  .temperature
    font-weight: 400

  .summary
    margin-top: -1px
    font-size: 11px
    text-transform: lowercase
    &:first-letter
      text-transform: uppercase
"""

render: (_) -> """
  <link rel="stylesheet" href="weather.widget/css/fontello.css">
  <div class="title">Weather</div>
  <div class="error"></div>
  <div class="weather">
    <span class="icon">
      <i class=""></i>
    </span>
    <div class="info">
      <div class="temperature"></div>
      <div class="summary"></div>
    </div>
  </div>
"""
iconMappings:
  "clear-day": "icon-sun-inv"
  "clear-night": "icon-moon-inv"
  "rain": "icon-rain-inv"
  "snow": "icon-snow-heavy-inv"
  "wind": "icon-wind"
  "fog": "icon-fog"
  "cloudy": "icon-cloud-inv"
  "partly-cloudy-day": "icon-cloud-sun-inv"
  "partly-cloudy-night": "icon-cloud-moon-inv"
  "hail": "icon-hail-inv"
  "thunderstorm": "icon-cloud-flash-inv"

firstFetch: true

update: (_, domEl) ->
  dom = $(domEl)
  if @firstFetch
    dom.find(".error").text "Not available"
    @firstFetch = false
  self = @
  @run "lib/scripts/wait-for-network.zsh", () ->
    # Get current location
    self.run "/usr/local/bin/CoreLocationCli -format '%latitude,%longitude'"
    , (_, coordinates) ->
      # Refresh after 10 seconds if location error
      if coordinates.includes("ERROR")
        setTimeout () ->
          self.refresh()
        , 10000
        return
      # Get weather from Dark Sky API
      temperatureString = ""
      summaryString = ""
      self.getWeather coordinates
      , (response) ->
        # Get data
        data = response.currently
        icon = data.icon
        temperature = Math.round data.temperature
        summary = data.summary
        # Format data
        iconClass = "icon-na"
        if icon in Object.keys(self.iconMappings)
          iconClass = self.iconMappings[icon]
        temperatureString = "#{temperature}°"
        summaryString = summary
        # Update DOM
        dom.find(".error").text ""
        dom.find(".icon i").attr("class", iconClass)
        dom.find(".summary").text summaryString
        dom.find(".temperature").text temperatureString
      , () ->
        self.refresh()

getWeather: (coordinates, successCallback, errorCallback) ->
  # Proxy
  proxyUrl = "http://127.0.0.1:41417/"
  # API
  baseUrl = "https://api.darksky.net/forecast"
  apiUrl = "#{baseUrl}/#{@apiKey}/#{coordinates}"
  exclude = "minutely,hourly,daily,alerts,flags"
  units = "si"
  apiUrl += "?exclude=#{exclude}&units=#{units}"
  # Request
  $.ajax {
    type: "GET"
    url: proxyUrl + apiUrl
    dataType: "json"
    success: (json) ->
      successCallback json
    error: errorCallback
  }
