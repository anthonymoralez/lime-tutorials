display.setStatusBar( display.HiddenStatusBar )

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
back:setFillColor(165/255, 210/255, 1)

-- Load Lime
lime = require("lime.lime")

-- Disable culling
lime.disableScreenCulling()

-- Load your map
local map = lime.loadMap("tutorial-17.tmx")

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
lime.buildPhysical(map)

local onTap = function( event )

	local pos = lime.utils.screenToWorldPosition( map, event )
	map:slideToPosition( pos.x, pos.y )
	
end

local onTouch = function( event )
	map:drag( event )
end

Runtime:addEventListener( "tap", onTap )
Runtime:addEventListener( "touch", onTouch )
