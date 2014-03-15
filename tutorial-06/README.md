NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/06-using-objects-to-do-cool-stuff/)

## 06 � Using Objects to Do Cool Stuff
Difficulty: Beginner

Duration: 20 minutes

Description:

Objects are a very important part of Tiled, they allow you to create things such as checkpoints, spawnpoints, pickups and much more. In this tutorial we will see how easy they are to use and then in the next tutorial we will see how they can be used to help set up your physical world.

### Step 1: Creating an object layer

Creating an object layer is straight forward, simply right click the Layers panel and select Add Object Layer..., this will create a new blank layer much like we did with tile layers:

![New Layer](http://lime.outlawgametools.com/tutorials/6/images/newLayer.jpg)

### Step 2: Creating your first object

Object layers can be quite fiddly to work with at first but you will get used to them over time, to create your object just click somewhere in the tile grid, ensuring that the object layer is selected.

![New Object](http://lime.outlawgametools.com/tutorials/6/images/newObject.jpg)

That little grey circle/square icon is your new object, exciting isn�t it?

### Step 3: Giving it some properties

To give your object some properties you will need to once again bring up the Properties window, do so by right clicking the object and selecting Object Properties�

![Property Window](http://lime.outlawgametools.com/tutorials/6/images/newLayer.jpg)

As you can see in the image, you are able to give each object a Name and Type value as well as as many properties as you like. You are also able to set its X and Y position as well as its Width and Height.

For now we will just skip the position and size data and just add a Name and Type like so:

![Object Name & Type](http://lime.outlawgametools.com/tutorials/6/images/objectType.jpg)

As well as just one property:

![Object Properties](http://lime.outlawgametools.com/tutorials/6/images/properties.jpg)

### Step 4: Using it in your game

With our object created and setup it is now time to use it in our game, now we could do as we have previously done and get access to this object by looping through all the objects but we can do this a much more interesting way with a lot less code, namely using object listeners.

To do this we must first load up our map but then before we create the visual we need to place the following code. It is vital that this is done before the visual is created.

```lua 
-- Create our listener function
local onObject = function(object)
    -- Create an image using the properties of the object
    display.newImage(object.playerImage, object.x, object.y)
end

-- Add our listener to our map linking it with the object type
map:addObjectListener("PlayerSpawn", onObject)
```

![In Game](http://lime.outlawgametools.com/tutorials/6/images/complete.jpg)

What we have seen is that it is very easy to do stuff with objects, obviously what I have shown you is a very basic idea but the feature itself can be used for so much more.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Guy Image: [Download](http://lime.outlawgametools.com/tutorials/6/resources/guy.png)

