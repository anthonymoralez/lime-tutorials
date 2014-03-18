lime = require("lime.lime")

local physics = require("physics")
physics.start()

local bg = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
bg:setFillColor(0.31,0.67,1.0)

local map = lime.loadMap("tutorial-09.tmx")

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

local onTouch = function(event)
  if (player.canJump) then
    player:applyLinearImpulse(0, -5, player.x, player.y)
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

  Runtime:addEventListener("touch", onTouch)

end
map:addObjectListener("PlayerSpawn", onPlayerSpawnObject)


local visual = lime.createVisual(map)
local physical = lime.buildPhysical(map)
