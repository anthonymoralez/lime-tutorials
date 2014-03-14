lime = require("lime.lime")
local widget = require( "widget" )


local map 
local visual
local function loadMap(mapFile) 
  if (map) then
    map:destroy()
    map = nil
    visual = nil
  end
  map = lime.loadMap(mapFile)
  visual = lime.createVisual(map)
  visual:toBack()
end

loadMap("tutorial-04.tmx")

local onOffSwitch = widget.newSwitch
{
  left = 10,
  top = 10,
  style = "onOff",
  id = "onOffSwitch",
  onPress = function ( event )
    if ( event.target.isOn) then
      loadMap("tutorial-04-external-tilesets.tmx")
    else
      loadMap("tutorial-04.tmx")
    end
  end
}
