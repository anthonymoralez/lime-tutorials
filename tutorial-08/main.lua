lime = require("lime.lime")

local bg = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
bg:setFillColor(0.31,0.67,1.0)

local map = lime.loadMap("tutorial-08.tmx")
local visual = lime.createVisual(map)
local physical = lime.buildPhysical(map)
