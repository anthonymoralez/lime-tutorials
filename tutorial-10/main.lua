lime = require("lime.lime")
local ui = require("lime.ui")

local physics = require("physics")
physics.start()

-- Player motion constants
local STATE_IDLE = "Idle"
local STATE_WALKING = "Walking"
local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1

local bg = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
bg:setFillColor(0.31,0.67,1.0)

local map = lime.loadMap("tutorial-10.tmx")

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

local onPlayerSpawnObject = function(object)
  local layer = map:getTileLayer("Player")
  player = display.newImage(layer.group, "guy.png")
  player.x = object.x
  player.y = object.y
  physics.addBody(player, { density = 1.0, friction = 0.3, bounce = 0.2 })

  player.collision = onCollision
  player:addEventListener( "collision", player )

end
map:addObjectListener("PlayerSpawn", onPlayerSpawnObject)


local visual = lime.createVisual(map)
local physical = lime.buildPhysical(map)


local onButtonLeftEvent = function(event)
  print( "left:".. event.phase)
    if event.phase == "press" then
        player.direction = DIRECTION_LEFT
        player.state = STATE_WALKING
    else
        player.state = STATE_IDLE
    end
end
local onButtonRightEvent = function(event)
  print( "right:"..event.phase)
    if event.phase == "press" then
        player.direction = DIRECTION_RIGHT
        player.state = STATE_WALKING
    else
        player.state = STATE_IDLE
    end
end
local onButtonAPress = function(event)
    if player.canJump then
        player:applyLinearImpulse(0, -5, player.x, player.y)
    end
end
local onButtonBPress = function(event)
end

Runtime:addEventListener("touch", function(event)
  print("touch:"..event.phase)
  if event.phase == "end" then
    player.state = STATE_IDLE
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
