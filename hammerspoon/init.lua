-- Hammmerspoon configuration
hs.console.darkMode(true)
hs.console.outputBackgroundColor({white = 0})
hs.console.consoleCommandColor({white = 1})
hs.console.consolePrintColor({white = 1})

-- Display AirPods battery information if connected
local airpodsAddress = "60-93-16-2a-3d-d5"
local function airpodsBattery()
  -- Check if any Bluetooth devices are connected
  local devices = hs.battery.privateBluetoothBatteryInfo()
  if #devices == 0 then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "No Bluetooth devices connected"
    }):send()
    return
  end
  -- Find AirPods
  local airpods = nil
  for _,device in ipairs(devices) do
    if device.address == airpodsAddress then
      airpods = device
      break
    end
  end
  if not airpods then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "AirPods not connected"
    }):send()
    return
  end
  -- Display AirPods battery information
  local left = "Left: " .. airpods.batteryPercentLeft .. "%"
  local right = "Right: " .. airpods.batteryPercentRight .. "%"
  local info = left .. "  " .. right
  local case = tonumber(airpods.batteryPercentCase)
  if case > 0 then
    info = info .. "\n" .. "Case: " .. case .. "%"
  end
  hs.notify.new({
    title = airpods.name,
    informativeText = info
  }):send()
end

-- Bind keys
local function catchEvent(event)
  if event:getFlags()['fn'] then
    local char = event:getCharacters()
    if char == "q" then
      airpodsBattery()
      return true, {}
    end
  end
end
tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, catchEvent)
tap:start()
