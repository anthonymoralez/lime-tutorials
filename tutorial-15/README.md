NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/15-building-a-platform-game-with-corona-and-lime/)

## 15 – Building a Platform Game with Corona and Lime
Difficulty: Intermediate

Duration: 30 minutes

Description:

In this tutorial I will be walking you through the code needed to create a platform game. I will be using the Corona SDK and Lime. Lime is a nice library for use with Corona that makes it easy to create tile based games with Tiled. If you don’t know what Tiled is, [check it out](http://www.mapeditor.org).

If you load the map into Tiled you will see two layers. The top layer is called “Physics”. This is the layer that will define all our objects. The bottom layer is called “Background” and will hold all the tiles that create the visual aspect of the map.

First thing to do is set up the main entry point for the game. In the main.lua file I have the following code. This will do a bit of setup for the app and create our platform world.

```lua
--Hide the status bar
display.setStatusBar( display.HiddenStatusBar )
--Enable multitouch
system.activate( "multitouch" )
--Include platform.lua
local platform = require("platform")
--Call the loadMap function in platform.lua
platform.loadMap("map.tmx")
```

Next is the initial setup of our platform.lua file.

```lua
--Include physics and start the physics simulation
require("physics")
physics.start()

--Load lime and assign to a variable
local lime = require("lime")
local Platform = {}
function Platform.loadMap(tmx)
    -- Create a sky blue background
    local bg = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
    bg:setFillColor(0.31,0.67,1.0)
    --Load the map into our instance of lime
    map = lime.loadMap(tmx)
    --Add a listener so we know when the player object has been loaded from the map
    map:addObjectListener("Player", onPlayerLoaded)
    --Tell lime to create the visual aspect of the world
    visual = lime.createVisual(map)
    --Tell lime to create the physics bodies needed for the world
    local physical = lime.buildPhysical(map)
end
```

Now that the map is loaded we can move on to the listener function referenced in the loadMap function. This method will get passed the player object defined in Tiled. Most of the properties are simply stored for use later. The object.sheet property is used to load the image used to represent the main character. 

```lua
function onPlayerLoaded(object)
    --Store properties for later use
    topSpeed = tonumber(object.topSpeed)
    floatForce = tonumber(object.floatForce)
    walkForce = tonumber(object.walkForce)
    jumpForce = tonumber(object.jumpForce)
    jumpDrag = tonumber(object.jumpDrag)
    wallJumpPower = tonumber(object.wallJumpPower)
    wallDrag = tonumber(object.wallDrag)
    --Create our player display object
    player = display.newImage(object.sheet)
    --Grab the layer display object and add the player to it
    local layer = map:getObjectLayer("Physics")
    layer.group:insert(player)
    --Add a collision listener and set the initial position of the player
    player:addEventListener( "collision", onPlayerCollision )
    player.x = object.x
    player.y = object.y
    --Create a physics body to represent the player and stop it from rotating
    physics.addBody(player, { density = object.density, friction = object.friction, bounce = object.bounce })
    player.isFixedRotation = true
    --Player is ready, setup the joystick
    setupJoystick()
end
```

Before I get into the collision detection I would like to step back and go over touch events and the main loop. Here is how those event listeners are defined.

```lua
Runtime:addEventListener("touch", onTouch)
Runtime:addEventListener("enterFrame", onPlatformLoop)
```

The first is the “touch” event. What I am going to do is use a joystick for left and right movement and a tap anywhere else on screen for the jump. The onTouch Method simply sets a variable to indicate whether the user has touched the screen anywhere. When a touch begins I am also calling a resetJump method. More on that part later though.

```lua
local function onTouch(event)
    if event.phase == "began" then
        resetJump()
    elseif event.phase == "ended" then
        touchDown = false
    end
end
```

Next up is the main loop. This gets called once every frame, so we can use it for updating our map position among other things.

```lua
local function onPlatformLoop(event)
    --If the player has been created set the map to center around the player
    if player then map:setPosition(player.x, player.y) end
    --If the user is touching the screen I will call this method
    if touchDown then onTouchIsDown() end
    --For the sake of clean code all player updates will be in another function
    updatePlayer()
end
```

Next step is to get the joystick controls in. For this I found a nice class for use in Corona SDK [here](http://developer.coronalabs.com/code/joystick). We setup the joystick when our player is loaded and ready to control. You can consult the joystick class for details on how to use it. I have a simple setup here since it is only used for left and right movement.

```
--Include joystick.lua
local joystickClass = require( "joystick" )
function setupJoystick()
  joystick = joystickClass.newJoystick{
    outerAlpha = 0.5,
    outerRadius = 20,
    innerAlpha = 1.0,
    innerRadius = 10,
    position_y = display.contentHeight - (display.contentHeight/4),
    onMove = onWalk
  }
  joystick:joystickStart()
end
```

One thing to note about the joystick is the onMove property points to the onWalk function. The onWalk function will test if the player can walk and apply a force to make the player move. The joystick updates its internal state based on touch events on it. The onMove callback is registered as a listener of the "enterFrame" Corona 

```lua
function onWalk( event )
  --Make sure the joystick is not in the neutral position
  if joystick.joyX ~= false then
    --Get the current velocity of the player
    vx, vy = player:getLinearVelocity()
    --Make sure we don't keep speeding up past the topSpeed
    local belowSpeed = vx > -topSpeed and vx < topSpeed;
    --Set a different speed for horizontal movement in the air
    local force = playerOnGround and walkForce or floatForce
    --Apply force to move the player
    if belowSpeed then player:applyForce( joystick.joyX * force, vy, player.x, player.y) end
  end
end
```

Back in our game loop we called a function named onTouchIsDown. Right now all this does is call the updateJump function. It may do more in the future but that’s for another day.

```lua
function onTouchIsDown()
    updateJump()
end
function updateJump()
    --Set the current force for the jump, will reset when user taps
    currForce = currForce - jumpDrag
    --Make sure the force is never negative
    if currForce < 0 then currForce = 0 end
    --If on the ground apply a horizontal force
    if playerOnGround then player:applyForce( 0, -currForce, player.x, player.y ) end
    --If the player is on the wall make him jump off
    if playerOnGround == false and playerOnWall then wallJump() end
end
function resetJump()
    --Set current force back to its initial value
    currForce = jumpForce
end
```

In our game loop I was also calling a function named “updatePlayer”. This is meant to adjust movement in different directions based on the state of the player.

```lua
function updatePlayer()
    -- Stop movement on the x axis in the air
    if joystick.joyX == false and playerOnGround == false then
        vx, vy = player:getLinearVelocity()
        player:setLinearVelocity(0, vy)
    end
    --Slide down walls slowly when pushing towards the wall
    if joystick.joyX ~= false and playerOnWall and wallJumping == false then
        player:setLinearVelocity(0, wallDrag)
    end
end
```

The wall jump function will allow our player to jump of walls. This is a fun feature in my opinion. I like wall jumping to reach high places.

```lua
function wallJump()
    --Only wall jump if joystick is not in the neutral position
    if joystick.joyX then
        --Don't try to wall jump if I am already wall jumping
        if wallJumping ~= true then
            --Get the side the wall is on to set our jump direction
            local xPower = wallOnLeft and wallJumpPower or -wallJumpPower
            local xPower = wallOnLeft and wallJumpPower or -wallJumpPower
            --Make the player jump
            player:setLinearVelocity(xPower, -(wallJumpPower*2))
        end
    end
end
```

Last up is collision detection. The physics engine in Corona handles all the real collision detection. What it won’t tell us is what side of an object the player hit. This is important if we want to wall jump. We need to know if we are hitting the ground or a wall. The following function is the listener that was set up when the player was created. In this function event.other refers to the physics body that our player has collided with. If the body has the property IsGround (which was set in the map) then we call hitGround or offGround based on whether the collision began or ended. We pass the collision object along since we will need to know its location and size later.

```lua
function onPlayerCollision(event)
    if event.phase == "began" then
        if event.other.IsGround then hitGround(event.other) end
    end
    if event.phase == "ended" then
        if event.other.IsGround then offGround(event.other) end
    end
end
```

When we call the hitGround function we need to test what side was hit and whether the collision was valid.

```lua
function hitGround(ground)
  --The player is no longer wall jumping if it hit a new ground object
  wallJumping = false
  --Check which side of the ground the player hit
  local hitSide = getCollisionSide(ground, player)

  --activeWall tracks the wall currently in contact with the player
  if activeWall == nil then
    playerOnWall = hitSide == 3 or hitSide == 4
    --If the player is on the wall set the active wall
    if playerOnWall then
      activeWall = ground
      wallOnLeft = hitSide == 3
    end
  end
  --activeGround tracks the ground currently in contact with the player
  --If not already touching the ground test for the ground
  if activeGround == nil then
    playerOnGround = hitSide == 2

    --If the player is on the ground then set the active ground and unset wall
    if playerOnGround then
      activeGround = ground
      activeWall = nil
      playerOnWall = false
    end
  end
end
```

The offGround function is more simple. If a collision ended and the wall is active then deactivate the wall. the same goes for the ground.

```lua
function offGround(ground)
    if ground == activeWall then
        activeWall = nil
        playerOnWall = false
    end
    if ground == activeGround then
        activeGround = nil
        playerOnGround = false
    end
end
```

Here is the method that checks which side of the ground object the player collided with. This is just a simple rectangle rectangle collision detection. The varaible names should make it self explanatory.

```lua
function getCollisionSide(ground, player)
    local groundX, groundY = ground.x - (ground.width / 2), ground.y - (ground.height / 2)
    local playerX, playerY = player.x - (player.width / 2), player.y - (player.height / 2)
    local groundLeft = groundX
    local playerLeft = playerX
    local groundRight = groundX+ground.width
    local playerRight = playerX+player.width
    local groundTop = groundY
    local playerTop = playerY
    local groundBottom = groundY+ground.height
    local playerBottom = playerY+player.height

    if groundBottom < playerTop then return 1 end
    if groundTop > playerBottom then return 2 end
    if groundRight < playerLeft then return 3 end
    if groundLeft > playerRight then return 4 end
end
```

That about wraps it up. As always please feel free to ask questions.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Tileset: [Download](http://lime.outlawgametools.com/tutorials/0/resources/tileset-platformer.png)

