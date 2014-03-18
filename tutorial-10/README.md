NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/09-controlling-a-platformer-characters-jump/)

## 10 – More Work on Platformer Characters
Difficulty: Beginner

Duration: 30 minutes

Description:

This tutorial is an extension to the previous tutorial so if you haven’t done that one yet please do so now. In this tutorial we will see how easy it is to give our player some basic movement controls. This is not the only way this can be achieved, this is just the way I am showing here, if you have a better way please email me.

### Step 1: Creating your map

We will be using a slightly modified (well, simplified) version of the map we created in the last tutorial, it still has the player spawn point that we used before however the terrain is nice and flat with friction added.

![The Map](http://lime.outlawgametools.com/tutorials/10/images/map.jpg)

You can download the map [here](tutorial-10).

### Step 2: Creating the HUD

For the controls I have borrowed some simple images, they are not great but get the job done as far as this tutorial is concerned.

You can download all the images for the controls here.

Following are four blocks of code, all standard stuff that set up our controls as ui buttons. Please remember to include ui.lua in the normal way.

```lua
local buttonLeft = ui.newButton{
    default = "buttonLeft.png",
    over = "buttonLeft_over.png",
    onEvent = onButtonLeftEvent
}
buttonLeft.x = buttonLeft.width / 2 + 10
buttonLeft.y = display.contentHeight - buttonLeft.height / 2 - 10
local buttonRight = ui.newButton{
    default = "buttonRight.png",
    over = "buttonRight_over.png",
    onEvent = onButtonRightEvent
}
buttonRight.x = buttonLeft.x + buttonRight.width
buttonRight.y = buttonLeft.y
local buttonA = ui.newButton{
    default = "buttonA.png",
    over = "buttonA_over.png",
    onEvent = onButtonAPress
}
buttonA.x = display.contentWidth - buttonA.width / 2 - 10
buttonA.y = display.contentHeight - buttonA.height / 2 - 10
local buttonB = ui.newButton{
    default = "buttonB.png",
    over = "buttonB_over.png",
    onEvent = onButtonBPress
}
buttonB.x = buttonA.x - buttonB.width
buttonB.y = buttonA.y
```

Your lovely new buttons should look something like this when the game is running.

![Controls](http://lime.outlawgametools.com/tutorials/10/images/controls.jpg)

### Step 3: Hooking up the controls

Currently our controls are hooked up to nothing as we have not created any event handlers, to do so place the following code blocks somewhere above the button creation code from the previous step.

```lua
local onButtonLeftEvent = function(event)
end
local onButtonRightEvent = function(event)
end
local onButtonAPress = function(event)
end
local onButtonBPress = function(event)
end
```

### Step 4: States and Directions

To keep track of what our player is doing we need a couple of variables that will be added to our player object, we also need some possible values for them and to make things easy to read we will define them at the top of our code.

```lua
local STATE_IDLE = "Idle"
local STATE_WALKING = "Walking"
local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1
```

The values for the two state variables could be anything including numbers however in the next tutorial we will use them to play state animations so we want them as strings and we will use the direction values to simplify movement.

### Step 6: Handling the events

Now that our controls are hooked up and we have our state and direction variables set up it is time to actually do something with them, to do so please update the left and right button event handlers to look like the following:

```lua
local onButtonLeftEvent = function(event)
    if event.phase == "press" then
        player.direction = DIRECTION_LEFT
        player.state = STATE_WALKING
    else
        player.state = STATE_IDLE
    end
end
local onButtonRightEvent = function(event)
    if event.phase == "press" then
        player.direction = DIRECTION_RIGHT
        player.state = STATE_WALKING
    else
        player.state = STATE_IDLE
    end
end
```

All these functions do are set the player state to Walking and the player direction when the button has been pressed and then set the state back to Idle when the button has been released.

You then need to update the A button event handler to use the code from the previous tutorial for jumping.

```lua
local onButtonAPress = function(event)
    if player.canJump then
        player:applyLinearImpulse(0, -5, player.x, player.y)
    end
end
```

### Step 7: The update function

The update function is where all the “work” gets done, in actual fact it is very simple as we are only going to have simple movement.

```lua
local onUpdate = function(event)
    if player.state == STATE_WALKING then
        player:applyForce(player.direction * 10, 0, player.x, player.y)
    elseif player.state == STATE_IDLE then
        local vx, vy = player:getLinearVelocity()
        if vx ~= 0 then
            player:setLinearVelocity(vx * 0.9, vy)
        end
    end
end
Runtime:addEventListener("enterFrame", onUpdate)
```

The first part of this code checks whether your player is in the Walking state or the Idle state. If your player is in the Walking state then you need to apply a force based on the players direction and if your player is in the Idle state then it simply lowers the linear velocity until the player has stopped.

### Step 8: Old code

You also need to make sure you have the collision code from the previous tutorial in place to allow your player to jump.

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

As well as the player spawn code, making sure to place it directly after you call lime.loadMap().

```lua
local onPlayerSpawnObject = function(object)
    local layer = map:getTileLayer("Player")
    player = display.newImage(layer.group, "guy.png")
    player.x = object.x
    player.y = object.y
end
map:addObjectListener("PlayerSpawn", onPlayerSpawnObject)
```

### Step 9: Run your game

If you run your game now your player be able to walk left and right as well as jump when you press the appropriate buttons.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
