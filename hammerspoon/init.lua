-- Hammmerspoon configuration
hs.console.darkMode(true)
hs.console.outputBackgroundColor({white = 0})
hs.console.consoleCommandColor({white = 1})
hs.console.consolePrintColor({white = 1})

-- Display AirPods battery information if connected
hs.urlevent.bind("display-airpods-battery", function(_, params)
  --- Check parameters
  if params["mac"] == nil then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "Expected \"mac\" parameter",
    }):send()
    return
  end

  -- Check if any Bluetooth devices are connected
  local devices = hs.battery.privateBluetoothBatteryInfo()
  if #devices == 0 then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "No Bluetooth devices connected",
    }):send()
    return
  end

  -- Find AirPods
  local airpods = nil
  for _,device in ipairs(devices) do
    if device.address == params["mac"] then
      airpods = device
      break
    end
  end
  if not airpods then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "AirPods not connected",
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
    informativeText = info,
  }):send()
end)

-- Move mouse to specified display
local screenPoints = {}
hs.urlevent.bind("move-mouse-to-display", function(_, params)
  -- Check parameters
  if params["display"] == nil then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "Expected \"display\" parameter",
    }):send()
    return
  end

  -- Parse param to number
  local display = tonumber(params["display"])
  if display == nil then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = "Expected \"display\" parameter to be a number",
    }):send()
    return
  end

  -- Get intended screen
  local screens = hs.screen.allScreens()
  local screen = screens[display]
  if screen == nil then
    hs.notify.new({
      title = "Hammerspoon",
      informativeText = string.format("Display %s was not found", display),
    }):send()
    return
  end

  -- Get the center point of screen
  -- Also cache the point to avoid calculating it again
  local uuid = screen:getUUID()
  local point = screenPoints[screen:getUUID()]
  if point == nil then
    local mode = screen:currentMode()
    point = {
      x = mode.w // 2,
      y = mode.h // 2,
    }
    screenPoints[uuid] = point
  end

  -- Move the mouse
  hs.mouse.setRelativePosition(point, screen)
end)
