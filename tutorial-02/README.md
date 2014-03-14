NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/00-making-your-first-map/)

## 02 � Taking Advantage of Properties

Difficulty: Beginner

Duration: 20 minutes

Description:
Properties allow you to create all kinds of gameplay, for instance perhaps you wanted to have health pickups in your game you could do so by adding a "healthBonus" property to your tile with a value of "50".

To keep Lime as generalised as possible I have decided to not implement any game specific features so in order to actually take advantage of properties you will have to write the code to deal with them.

I will be releasing tutorials over time that provide sample code for using properties in lots of interesting ways so stay tuned.

### Step 1: Understanding what a property is

A property is simply a pair of data items, a Name and a Value. Everything in Tiled can have as many properties as you like. Possible uses are that you could give your Map a property that holds the level name or you could give a tile a property to be used as a health pickup.

### Step 2: Adding a property

In this tutorial we will add a tile property just to show it working, but I will also list how to add properties to everything else as well.

With your map loaded up in Tiled you can add a property to a tile by right clicking it in the tileset and select Tile Properties� to bring up the Property window:

![Property Window](http://lime.outlawgametools.com/tutorials/2/images/propertyWindow.jpg)

Now simply set a Name and Value for each property you want to add, I have just created one but you can create as many as you like:

![New Property](http://lime.outlawgametools.com/tutorials/2/images/newProperty.jpg)

With your property created make sure to add atleast one of those tiles to your map and then save it.
Please note that due to a bug in Tiled on OSX it is vital that you press enter when you have entered your new property before pressing the Ok button.

### Step 3: Using the property in your game

In this tutorial I will show a very basic, and pretty boring, use for properties however you will get an understanding of how they work and one of the ways you can access them while in later tutorials we will see more interesting things we can do with them.

Firstly you will need to load up your map as we did in the first tutorial and then get access to the tile layer that your new tile is on:

```local layer = map:getTileLayer("Tile Layer 1")```
 

With your layer stored off you can now get a list of all tiles that are on it like so:

```local tiles = layer.tiles```
 

What we now need to do is simply loop through all the tiles printing off any properties they have, like this:

```
-- Loop through our tiles
for i=1, #tiles, 1 do

    -- Get a list of all properties on the current tile
    local tileProperties = tiles[i]:getProperties()

    -- Loop through the properties, if any
    for key, value in pairs(tileProperties) do

        -- Get the current property
        local property = tileProperties[key]

        -- Print out its Name and Value
        print(property:getName(), property:getValue())
    end
end
```

With the code saved just run your game, you will see something similar to the following in the Terminal:

![Complete](http://lime.outlawgametools.com/tutorials/2/images/complete.jpg)

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

