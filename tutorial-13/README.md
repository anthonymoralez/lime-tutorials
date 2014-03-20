NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/13-moving-a-map-via-touch/)

## 13 – Moving a Map via Touch
Difficulty: Beginner

Duration: 10 minutes

Description:

This tutorial shows off how you can easily move your map around via tap/touch events. It also shows that platformer style maps aren’t the only thing you can make.

### Step 1: Creating your map

Any map will do for this however I have created an RPG style map just to be different.

![The Map](http://lime.outlawgametools.com/tutorials/13/images/map.jpg)

You can download the map [here](tutorial-13.tmx).

### Step 2: Adding the tap code

Firstly we will see how you can move around the map based on a tap from the user, naturally you could use any other method you like for actually getting the position you wish to move the map to.

You will need to add all the code like normal to simply load up a map and its visual, no need for physics or any other features for now.

Now create a tap event listener function like so:

```lua
local onTap = function(event)
    local screenPosition = { x = event.x, y = event.y }
    local worldPosition = lime.utils.screenToWorldPosition(map, screenPosition)
    -- Instantly jump to the new position
    map:setPosition(worldPosition.x, worldPosition.y)
    -- Fade out, set position and then fade back in again
    --  map:fadeToPosition(worldPosition.x, worldPosition.y, 1000)
    -- Slide to the new position
    --  map:slideToPosition(worldPosition.x, worldPosition.y, 2000)
end
Runtime:addEventListener("tap", onTap)
```

### Step 3: Run your game

If you run your game now and tap somewhere on the map you will notice that the map gets recentred imediately around the tap position, try commeting back in the other map movement functions above to see them in action.

### Step 4: Adding the touch code

Dragging the map is even simpler, just add a touch event listener function like this:

```lua
local onTouch = function(event)
    map:drag(event)
end
Runtime:addEventListener("touch", onTouch)
```

You may want to comment out the tap listener for now to see this working.

### Step 5: Run your game again

Now run your game and drag your map around.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Tileset: [Download](forest.png)

