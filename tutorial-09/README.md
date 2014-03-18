NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/09-controlling-a-platformer-characters-jump/)

## 09 – Controlling a Platformer Character’s Jump
Difficulty: Beginner

Duration: 30 minutes

Description:

In this tutorial you will see how easy it is to make a sprite jump via physics. This is not the only way this can be achieved, this is just the way I am showing here, if you have a better way please email me.

### Step 1: Getting your map

To keep things simple we are going to use an already created map that was built using concepts learned in previous tutorials. The map is a single screen map that you will recognise.

You can download the map [here](tutorial-09.tmx).

The map has the physical terrain already set up as well as a positioned object which we will use to create our player.

### Step 2: Creating our player

To create our player we will use the Object Listener features, in your main.lua file before you call lime.createVisual() place the following code snippet:

```lua
local onPlayerSpawnObject = function(object)
    local layer = map:getTileLayer("Player")
    player = display.newImage(layer.group, "guy.png")
    player.x = object.x
    player.y = object.y
end
map:addObjectListener("PlayerSpawn", onPlayerSpawnObject)
```

All this code does is first get a layer called "Player" in our map, then create an image object at the position of our spawn object making sure to add it to the layer group.

If you ran your game now you would get your little player image loaded up in the map and nothing else interesting happening.

![Player In Game](http://lime.outlawgametools.com/tutorials/9/images/playerInGame.jpg)

### Step 3: Making him jump

To make our player jump using physics we first must make him physical, to do so you will need to initially start up the physics engine by placing the following code somewhere at the top of your main.lua file:

```lua
require("physics")
physics.start()
```

With that done you will now need to make your physics body, this is done by adding one line of code to our object listener, just after you have set the players position:

```lua
physics.addBody(player, { density = 1.0, friction = 0.3, bounce = 0.2 })
```

![Physics In Game](http://lime.outlawgametools.com/tutorials/9/images/physicsInGame.jpg)

Now if you run the game your player will fall gracefully to the ground landing nicely in front of the little plant, this is because of layering.

The next step is to make him jump, in this tutorial I will simply add this function to a "tap" event however you may wish to activate it some other way such as when your player taps a jump button or tilts the device.

To do this simply create a "touch" event listener and then apply an impulse to the player, like so:

```lua
local onTouch = function(event)
    player:applyLinearImpulse(0, -5, player.x, player.y)
end
Runtime:addEventListener("touch", onTouch)
```

Nice and simple really, just apply a small impulse to our player everytime the user taps the screen. Run the game and test it out, you will notice that your player is able to jump in mid-air simply by tapping multiple times, we will now fix that.

### Step 4: Limiting the jump

In order to limit the jump we must first decide how we want to limit it, for the purposes of this tutorial we will say that we only want our player to be able to jump if he is currently on the ground.

Now that we have decided our limitation we need to think about the implementation, we could either go about this by saying our player can only jump when touching a ground object or that he can’t jump when in the air. I have decided to go down the former route simply so that I can show the use of collision events, you may wish to go another way in your games.

To start off with we will put a simple check around our jump function to make sure that the player can only jump when we allow him to do so:

```lua
local onTouch = function(event)
    if player.canJump then
        player:applyLinearImpulse(0, -5, player.x, player.y)
    end
end
Runtime:addEventListener("touch", onTouch)
```

If you ran your game now all we have done is broken the jump function as player.canJump will always be false, to fix this we need to make our collision event listener:

```lua
local function onCollision(self, event )
    if ( event.phase == "began" ) then
       
    elseif ( event.phase == "ended" ) then
       
    end
end
player.collision = onCollision
player:addEventListener( "collision", player )
```

What we have here is an empty collision event handler that checks the phase of the collision but does nothing. We could simply have it so that on collision began it sets player.canJump to true and on collision ended set it back to false again, but what happens when our player bumps into other things that we don’t want to allow him jumping on like water or glue? Simple, we specifiy which object is actually a ground object which we can do this through the use of properties in Tiled.

In the map that I have provided I have already set up the properties how we need them but just so we are all clear, all I have done is given each physics object (making sure to include each of the control points for the centre terrain) an "IsGround" property, they don’t need a value as all we care about is the existence of the property itself but you could be fancy here and change it to "GroundType" to enable different jump powers on different surfaces.

With these properties set up it is just a simple addition to the collision event to enable and disable jumping, the updated code is below:

```lua
local function onCollision(self, event )
    if ( event.phase == "began" ) then
        if event.other.IsGround then
            player.canJump = true
        end
    elseif ( event.phase == "ended" ) then
        if event.other.IsGround then
            player.canJump = false
        end
    end
end
player.collision = onCollision
player:addEventListener( "collision", player )
```

The new code is highlighted and fairly easy to understand, the important thing to realise here is that event.other is not a Tiled Object but in fact a Corona physics body. Lime has handily copied over all the properties that you may have set on the Tiled Object (including our "IsGround" property) to make things simpler for us.

### Step 5: Run your game

If you run your game now your player will now be limited to jumping only when he is on the ground.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
