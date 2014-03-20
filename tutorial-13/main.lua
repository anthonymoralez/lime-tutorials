lime = require("lime.lime")
local map = lime.loadMap("tutorial-13.tmx")
local visual = lime.createVisual(map)


local onTap = function(event)
  local screenPosition = { x = event.x, y = event.y }
  local worldPosition = lime.utils:screenToWorldPosition(map, screenPosition)
  -- Instantly jump to the new position
  map:setPosition(worldPosition.x, worldPosition.y)
  -- Fade out, set position and then fade back in again
  --  map:fadeToPosition(worldPosition.x, worldPosition.y, 1000)
  -- Slide to the new position
  --  map:slideToPosition(worldPosition.x, worldPosition.y, 2000)
end
Runtime:addEventListener("tap", onTap)

local onTouch = function(event)
  map:drag(event)
end
Runtime:addEventListener("touch", onTouch)
