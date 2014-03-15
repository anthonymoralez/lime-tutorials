lime = require("lime.lime")
local map = lime.loadMap("tutorial-02.tmx")

-- Note that the tileSet properties don't get added to the layer.tiles until the
-- map visual is created.
local visual = lime.createVisual(map)


-- get the layer from the map 
local layer = map:getTileLayer("Tile Layer 1")
-- get the tiles out of the layer
local tiles = layer.tiles
-- Loop through our tiles
for i=1, #tiles, 1 do
    -- Get a list of all properties on the current tile
    local tileProperties = tiles[i]:getProperties()

    -- Loop through the properties, if any
    for key, value in pairs(tileProperties) do

        -- Get the current property
        local property = tileProperties[key]

        -- Print out its Name and Value
        if (property:getName() ~= "index") then
          print(property:getName(), property:getValue()) 
        end
    end
end

