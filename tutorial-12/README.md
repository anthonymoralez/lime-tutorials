NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/12-collectible-items/)

## 12 – Collectible Items
Difficulty: Beginner

Duration: 15 minutes

Description:

This tutorial is an extension to the [previous tutorial](../tutorial-11) so if you haven’t done that one yet please do so now. In this tutorial we will see how easy it is to give our player some basic animations. This is not the only way this can be achieved, this is just the way I am showing here, if you have a better way please email me.

### Step 1: Getting your map

We will be using the exact same map we created in the last tutorial, so go ahead and make of a copy of that project now as we need the code as well.

![The Map](http://lime.outlawgametools.com/tutorials/12/images/map.jpg)

You can download the map [here](tutorial-12.tmx).

### Step 2: Creating the item properties

To get pickups to work we will be using custom properties, please remember that you can choose to go about tasks such as this any way you wish and this solution is just one of many.

The following image shows the item properties that you will need on your collectible tile. For this tutorial I have added these properties to a block tile from the standard tileset however you may want to create an animated tile such as a coin or ring for your game.

![Item Properties](http://lime.outlawgametools.com/tutorials/12/images/itemProperties.jpg)

As you can see I have the now basic physics properties to make it a static body however I have also added an “isSensor” property, this is built in Corona/Box2D property that essentially turns your body into a ghost allowing objects to pass through it yet still register collisions. Your tile doesn’t require this property however without it your player will bounce off it, which may be a desired effect if you are going for a Mario style coin brick, however for this tutorial we will keep things simple.

The only other properties needed are our custom ones that define our pickup item, however please remember these tutorials are only showing one possible solution and you may wish to define your pickups (and other items) in a completely different way and could also include animations etc.

### Step 3: Adding the code

The code to get this working is very simple, all you need to do is add another check in your onCollision event that was set up for the player to control jumping.

```lua
if event.other.IsPickup then
    -- Deal with your collectible here
end
```

The following shows a very simple way of dealing with your score pickup.

```lua
if event.other.IsPickup then
  local item = event.other
  local onTransitionEnd = function(s) 
    return function(evt)
      evt:removeSelf()
    end
  end
  -- fade out the item
  transition.to(item, {time = 500, alpha = 0, onComplete=onTransitionEnd("item")})
  if item.pickupType == "score" then
    local text = display.newText( item.scoreValue .. " Points!", 0, 0, "Helvetica", 50 )
    text:setFillColor(0, 0, 0, 255)
    text.x = display.contentCenterX
    text.y = text.height / 2
    transition.to(text, {time = 1000, alpha = 0, onComplete=onTransitionEnd("text")})
  end
end
```

All fairly simple stuff, all it does is fade out the item, making sure to remove it from the world when the transition is complete, and then display some text based on the score value which also gets removed at the end. In a real game you would also want to add this score value to a player score variable stored somewhere.

### Step 4: Run your game

If you run your game now you will be able to collect some items. Naturally no score actually gets saved but that can come in a later tutorial.

![Complete](http://lime.outlawgametools.com/tutorials/12/images/complete.jpg)

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
