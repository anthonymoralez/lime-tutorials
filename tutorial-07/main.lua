lime = require("lime.lime")
local map = lime.loadMap("tutorial-07.tmx")
local visual = lime.createVisual(map)
local physical = lime.buildPhysical(map)
