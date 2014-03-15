NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/05-adding-life-through-animation/)

## 05 – Adding Life Through Animation
Difficulty: Beginner

Duration: 15 minutes

Description:

Currently Lime has two ways of supporting animated tiles, the first is very simple using frame based animations and the second method is still very simple but requires a little more work from the developer to get working, but because of this you get more control and flexibility.

By the end of this tutorial you will be able to use both methods in your maps.

### Step 1: Creating your properties

To have a simple animated tile you only need to add two properties, the first – IsAnimated – will simply tell Lime that this tile should be animated and the second – frameCount – tells it how many tiles to include.

You can also adjust the loopCount and startFrame if you want to.

![Animation Properties](http://lime.outlawgametools.com/tutorials/5/images/properties.jpg)

For my map I have once again decided to use the little red brick but you could of course use any other tiles in any tileset.

### Step 2: Adding your tile

Now that you have created the properties for your first animated tile you just need to add the tile to a layer just like any other.

![Tile In Map](http://lime.outlawgametools.com/tutorials/5/images/tileInMap.jpg)

### Step 3: Run your game

With the animation running in your game you will notice that it is very fast, that is because currently it is frame based rather than time based, but for simple animations this might still be useful. The next section will explain time based animations.

![Animated Map](http://lime.outlawgametools.com/tutorials/4/images/animation.swf)


### Step 4: More advanced usage

Currently you are stuck with your tile only having one possible animation, wouldn’t it be great if you could use Corona animation sequences with them? Yea I thought so too so here you go.

To use sequences you need a couple more properties set on your tile, you can also remove the frameCount property as it is no longer needed.

First off you will need to create a sequences property which will list all the animation sequences this tile should have. They should be seperated with a comma and contain no whitespace.

For each sequence listed you will need to create a property with the same name. As you can see in the following image I have created two sequences, each sequence can have a number of properties specified such as frameCount=3 and time=1000, please note the use of commas again as well as equals signs and also no whitespace.

![More Properties](http://lime.outlawgametools.com/tutorials/5/images/moreProperties.jpg)

If you run your game now you will notice something, your animation no longer plays. That is because you must tell Lime to play your animations, giving you more control over them.

### Step 5: Dealing with the new animations

Now that you have your sequences set up you are ready to test them in game and just like the Properties tutorial we now need to get access to our animated tiles. Then after we have it we can prepare the animation and start playing it.

```lua
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
                tile.sprite:prepare("animation1")
                -- Now finally play it
                tile.sprite:play()
            end
        end
    end
end
```

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
