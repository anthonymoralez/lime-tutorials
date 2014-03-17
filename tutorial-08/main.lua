lime = require("lime.lime")
local map = lime.loadMap("tutorial-08.tmx")
local visual = lime.createVisual(map)
local physical = lime.buildPhysical(map)
