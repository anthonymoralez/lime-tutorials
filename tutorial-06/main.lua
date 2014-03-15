print("contentWidth: "..display.contentWidth.." contentHeight: "..display.contentHeight)
lime = require("lime.lime")
local map = lime.loadMap("tutorial-06.tmx")

-- Create our listener function
local onObject = function(object)
    -- Create an image using the properties of the object
    display.newImage(object.playerImage, object.x, object.y)
end

-- Add our listener to our map linking it with the object type
map:addObjectListener("PlayerSpawn", onObject)

local visual = lime.createVisual(map)
