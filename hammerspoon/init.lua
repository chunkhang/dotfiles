require("hs.ipc")

-- Hammmerspoon configuration
hs.allowAppleScript(true)
hs.console.darkMode(true)
hs.console.outputBackgroundColor({white = 0})
hs.console.consoleCommandColor({white = 1})
hs.console.consolePrintColor({white = 1})
hs.ipc.cliInstall()
hs.ipc.cliColors({initial = "", input = ""})

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

--- Use fn for scrolling
local pixels = 50
local function catchEvent(event)
  if event:getFlags()['fn'] then
    local char = event:getCharacters()
    if char == "j" then
      return true, {hs.eventtap.event.newScrollEvent({0, -pixels}, {}, "pixel")}
    elseif char == "k" then
      return true, {hs.eventtap.event.newScrollEvent({0, pixels}, {}, "pixel")}
    elseif char == "h" then
      return true, {hs.eventtap.event.newScrollEvent({pixels, 0}, {}, "pixel")}
    elseif char == "l" then
      return true, {hs.eventtap.event.newScrollEvent({-pixels, 0}, {}, "pixel")}
    elseif char == "q" then
      airpodsBattery()
      return true, {}
    end
  end
end
tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, catchEvent)
tap:start()

-- Notify that hammerspoon has done loading
hs.notify.new({
  title = "Hammerspoon",
  informativeText = "Hammerspoon loaded",
}):send()
