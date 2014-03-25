NOTE: This tutorial is not copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/19-using-director-with-lime/). It is similar but reworked to use the new-ish [storyboard api](http://docs.coronalabs.com/api/library/storyboard/)

## 19 - Using storyboard with lime
Difficulty: Beginner

Duration: 30 minutes

Description:

This tutorial will add a start screen, a pause button to [tutorial-11](..\tutorial-11). We will be using the [storyboard api](http://docs.coronalabs.com/api/library/storyboard/) introduced in late 2011. 

### Step 1: Getting the map

The map can be found [here](tutorial-19.tmx). It is the same map used in [tutorial-11](..\tutorial-11). This was the one that added animation to a moving character. 

### Step 2: Making a scene

The primary unit of the storyboard API is the scene. The scene is a container for each scene in your application. Each scene has a `view` property that will be on screen when the scene is shown. The storyboard API provides functions for switching between scenes. Scenes are referenced by the sceneName. The name can either be the name of the lua module you've created, or the name you passed to [storyboard.newscene](http://docs.coronalabs.com/api/library/storyboard/newScene.html). 

So let's make our first scene. The Corona API docs for [the storyboard API](http://docs.coronalabs.com/api/library/storyboard/index.html) includes a [template](http://docs.coronalabs.com/api/library/storyboard/index.html#scenetemplate.lua) to help with implementing a scene. There is also a copy of scenetemplate.lua in this project. We'll rename that to [startscreen.lua](startscreen.lua). On [this line](startscreen.lua#L24) we add a simple displayObject that will be our background. At this point we have a simple blue background. That's boring. 

### Step 3: Switching scenes

Transitioning from one scene to the next is straight forward: use [storyboard.gotoScene](http://docs.coronalabs.com/api/library/storyboard/gotoScene.html). The optional `options` parameter is allows you to pass information from one scene to the next via the `params` member. You can also specify transition effects like we do [on this line](startscreen.lua#L31).

### Step 4: Loading lime inside a scene

The important thing to remember here is that you need to add the map visuals to the scene's group like we do [here](game.lua#L30). We've renamed the [main.lua](..\tutorial-11\main.lua) from tutorial-11 to [platform.lua](platform.lua) and tweaked it to provide a module with a public funtion to load the map, visuals, and physics as we did in tutorial 11. 

### Step 5: Pausing the scene with an overlay

We will now add a pause button to the game scene. We want this button to display a modal message over our existing scene. As you may have guessed the storyboard API supports this usage. The [storyboard.showOverlay](http://docs.coronalabs.com/api/library/storyboard/showOverlay) function is similar to the `gotoScene`, but instead of replacing the existing scene it is overlayed on top of it. To do this we'll create a new and very [simple scene](pause.lua).

Do this in the `createScene` function:

```lua
local pause = display.newImage(group, "Play_Button.png")
pause:addEventListener("tap", function(event) 
  storyboard.showOverlay("pause", { isModal = true })
end)
```

When the paused overlay is started we will unregister the `enterFrame` listener added when the map was loaded. When it is dismissed we'll re-register the listener. These operations are exposed from the platform module as public fuctions `resumeGame` and `pauseGame` respectively. So finally do this in the `overlayBegan` and `overlayEnded` listeners:

```lua
function scene:overlayBegan( event )
  platform.pauseGame()
end

function scene:overlayEnded( event )
  platform.resume()
end

```

That's the basics of using the storyboard API with lime.


Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
