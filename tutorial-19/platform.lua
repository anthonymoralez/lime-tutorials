local Platform = {}
lime = require("lime.lime")
local ui = require("lime.ui")

local physics = require("physics")
physics.start()

-- Player motion constants
local STATE_IDLE = "Idle"
local STATE_WALKING = "Walking"
local STATE_JUMPING = "Jumping"
local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1

local map
local visual
local physical
local player
local onUpdate
local onPlayerProperty

Platform.loadMap = function() 
  map = lime.loadMap("tutorial-19.tmx")
  map:addPropertyListener("IsPlayer", onPlayerProperty)

  visual = lime.createVisual(map)
  physical = lime.buildPhysical(map)
  Platform.resumeGame()
  return {map, visual, physical}
end

Platform.pauseGame = function()
  physics.pause()
  Runtime:removeEventListener("enterFrame", onUpdate)
end

Platform.resumeGame = function()
  physics.start()
  Runtime:addEventListener("enterFrame", onUpdate)
end

onUpdate = function(event)
  if player then else return end
  if player.state == STATE_WALKING then
    player:applyForce(player.direction * 10, 0, player.x, player.y)
  elseif player.state == STATE_IDLE then
    local vx, vy = player:getLinearVelocity()
    if vx ~= 0 then
      player:setLinearVelocity(vx * 0.5, vy)
    end
  end
end


local function onCollision(self, event )
  if ( event.phase == "began" ) then
    if event.other.IsGround then
      player.canJump = true       
      if player.state == STATE_JUMPING then
        player.state = STATE_IDLE
        player:setSequence("anim" .. player.state)
        player:play()
      end
    end
  elseif ( event.phase == "ended" ) then
    if event.other.IsGround then
      player.canJump = false
    end
  end
end


function onPlayerProperty(property, type, object)
  print("here")
  player = object.sprite

  player.state = STATE_IDLE
  player:setSequence("anim" .. player.state)
  player:play()
  player.collision = onCollision
  player:addEventListener( "collision", player )
end

local onButtonLeftEvent = function(event)
  if event.phase == "press" then
    player.direction = DIRECTION_LEFT
    player.xScale = DIRECTION_LEFT
    player.state = STATE_WALKING
    player:setSequence("anim" .. player.state)
    player:play()
  else
    player.state = STATE_IDLE
    player:setSequence("anim" .. player.state)
    player:play()
  end
end

local onButtonRightEvent = function(event)
  if event.phase == "press" then
    player.direction = DIRECTION_RIGHT
    player.xScale = DIRECTION_RIGHT
    player.state = STATE_WALKING
    player:setSequence("anim" .. player.state)
    player:play()
  else
    player.state = STATE_IDLE
    player:setSequence("anim" .. player.state)
    player:play()
  end
end
local onButtonAPress = function(event)
  if player.canJump then
    player:applyLinearImpulse(0, -5, player.x, player.y)
    player.state = STATE_JUMPING
    player:setSequence("anim" .. player.state)
    player:play()
  end
end

local onButtonBPress = function(event)
end

Runtime:addEventListener("touch", function(event)
  if event.phase == "end" then
  player.state = STATE_IDLE
  player:setSequence("anim" .. player.state)
  player:play()
end
end)

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


return Platform
