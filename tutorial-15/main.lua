--Hide the status bar
display.setStatusBar( display.HiddenStatusBar )
--Enable multitouch
system.activate( "multitouch" )
--Include platform.lua
local platform = require("platform")
--Call the loadMap function in platform.lua
platform.loadMap("tutorial-15.tmx")

