--Include physics and start the physics simulation
require("physics")
physics.start()

--Load lime and assign to a variable
lime = require("lime.lime")
local Platform = {}
function Platform.loadMap(tmx)
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

local function onTouch(event)
  if event.phase == "began" then
    resetJump()
  elseif event.phase == "ended" then
    touchDown = false
  end
end

local function onPlatformLoop(event)
  --If the player has been created set the map to center around the player
  if player then map:setPosition(player.x, player.y) end
  --If the user is touching the screen I will call this method
  if touchDown then onTouchIsDown() end
  --For the sake of clean code all player updates will be in another function
  updatePlayer()
end

Runtime:addEventListener("touch", onTouch)
Runtime:addEventListener("enterFrame", onPlatformLoop)

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
  touchDown = true
end

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

function onPlayerCollision(event)
  if event.phase == "began" then
    if event.other.IsGround then hitGround(event.other) end
  end
  if event.phase == "ended" then
    if event.other.IsGround then offGround(event.other) end
  end
end

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

return Platform
