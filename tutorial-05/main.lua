lime = require("lime.lime")
local map = lime.loadMap("tutorial-05.tmx")
local visual = lime.createVisual(map)

-- We first need to get access to the layer our tile is on, the name is specified in Tiled
local layer = map:getTileLayer("Tile Layer 1")

-- Make sure we actually have a layer
if(layer) then
    -- Get all the tiles on this layer
    local tiles = layer.tiles
    -- Loop through our tiles
    for i=1, #tiles, 1 do
        -- Check if the tile is animated (note the capitalization)
        if(tiles[i].IsAnimated) then
            -- Store off a copy of the tile
            local tile = tiles[i]
            -- Check if the tile has a property named "animation1"
            if(tile.animation1) then
                -- Prepare it through the sprite
                tile.sprite:setSequence("animation1")
                -- Now finally play it
                tile.sprite:play()
            end
        end
    end
end

