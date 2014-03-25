local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local centerX = display.contentWidth/2
local centerY = display.contentHeight/2

function scene:createScene( event )
  local group = self.view

  -- create a nice blue background for this overlay
  local bg = display.newRect(centerX, centerY, display.contentWidth/2, display.contentHeight/2)
  bg:setFillColor(0.31)
  group:insert(bg)

  -- Draw a paused message
  
  local message = display.newText{parent=group, text="Paused...", font=native.systemFontBold, fontSize=32, x=centerX, y=centerY-48}

  -- and a resume button
  local resume = display.newImage(group, "Play_Button.png")
  resume:translate(centerX, centerY)
  resume:addEventListener("tap", function(event) 
    storyboard.hideOverlay{effect="fade", time=300}
  end)
end

scene:addEventListener( "createScene", scene )
return scene
