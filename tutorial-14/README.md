NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/00-making-your-first-map/)

## 14 – Config Files

Difficulty: Intermediate

Duration: 15 minutes

Description:

This tutorial shows off how to use config files for easy object definitions.

### Step 1: Creating your map

To keep things simple for this I am going back to basics and have created a map very similar to the first one.

![The Map](http://lime.outlawgametools.com/tutorials/14/images/map.png)

You can download the map [here](tutorial-14).

### Step 2: Creating a config file

A config file is simply a JSON file so if you don’t know what that is please have a little read up on them. Google is your friend.

We will create a very basic config file that defines our ground object for the map:

```json
{
    "type":"Body",
    "bodyType":"static"
}
```

As you can see, all we are doing is using the same properties that you would normally set in Tiled. Note that as we are making our ground from an Object so we don’t use the “HasBody” property but instead set the “type” to “Body”. Save this file as “ground.json” in your Resource directory.

### Step 3: Using the config file

Now load up Tiled and on the Object Layer there will be a single Object for the ground, give it a property of “configFile” and a value of “ground.json”. If you wanted to load a config file from your Documents directory then you would change the value to “documents|ground.json”.

![Object Properties](http://lime.outlawgametools.com/tutorials/14/images/objectProperties.png)

If you ran your game now your ground object will be built, however naturally you can’t actually see anything. So to prove this all works create the following config file and save it as “redBlock.json”.

```json
{
    "HasBody":"",
    "bounce":1.0
}
```

Again, all regular stuff for making a nice bouncy block. Not that exciting but it will do for now. Now hook that up to the red tile (or any tile really) just like you did with the ground object and run the game. Voila!

![In Game](http://lime.outlawgametools.com/tutorials/14/images/InGame.png)

One useful feature of these config files are that you can now hook that config file up to any other tile and give it the same properties, for instance try hooking it up to the other red tile and see it bounce too.

### Step 4: More config files

Now create the following two config files and call them “greenBlock.json” and “yellowBlock.json” respectively. I think you can guess which tiles I would like them hooked up to.

```json
{
    "HasBody":"",
    "bounce":0.5
}
{
    "HasBody":"",
    "bounce":0
}
```

Running the game now you will see your objects all behave differently based on their config files. Try adding in other properties to see what happens.

![Complete](http://lime.outlawgametools.com/tutorials/14/images/Complete.png)

### Step 5: Nested config files

Another cool feature is nested config files, this allows for a basic form of inheritance. I won’t actually demo this in the game however I will explain how you can set it up and let you have fun with it.

Instead of creating each config file as before you could create a single one called “block.json” that simply defines the base block object, like so:

```json
{
    "HasBody":"",
}
```

You could then create a “redBlock.json” config file like this:

```json
{
    "configFile":"block.json",
    "bounce":1.0
}
```

See what I did there? I specified a config file from within another config file, meaning whatever you hook the “redBlock.json” file up to will also get all properties included in the “block.json” file too. I know, amazing right?

These nested config files could go on forever constantly including other files as they go down, however the one limitation of this is that you can only have one “configFile” property on an object or config file, just like you can only have one “anything” property on any table in Lua. Sucks right? It’s ok, I got you covered. Please move on to the next step :-)

### Step 5: Multiple config files

From within any config file you can give it a property of “configFiles”, this allows you to specify as many files as you desire, like so:

```json
{
    "configFiles":[ "configFile1.json", "configFile2.json", "configFile3.json" ]
}
```

An important thing to take away from this is also that what you are defining here is actualy a Lua table, so if you want to create fairly complex properties that you couldn’t do in Tiled then you can do in a config file, like this:

```json
{
    "type":"racingCar",
    "waypoints":[ "waypoint1", "waypoint2", "waypoint3" ],
    "colour":[ 255, 0, 0 ],
    "otherDetails":{ "cost":200, "name":"Awesome Car" }
}
```

### Step 6: Why would this be useful?

One reason is that it allows all the things mentioned above such as reuse of config data, inheritance and defining complex objects that would be tricky to do in Tiled but other benefits are that it allows a programmer to define an object and then a designer can just use that object in Tiled without knowing, or caring, how it is all set up. It also allows a programmer to tinker with gameplay values without having to get his feet wet in Tiled.

One other cool advantage of this is that it allows you to use the dynamic assets feature of the Corona Project Manager to swap out different config files in order to test different things.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Map: [Download](tutorial-14.tmx)

Tileset: [Download](http://lime.outlawgametools.com/tutorials/14/resources/tileset-platformer.png)

Ground config file: [Download](http://lime.outlawgametools.com/tutorials/14/resources/ground.json)

Red block config file: [Download](http://lime.outlawgametools.com/tutorials/14/resources/redBlock.json)

Green block config file: [Download](http://lime.outlawgametools.com/tutorials/14/resources/greenBlock.json)

Yellow block config file: [Download](http://lime.outlawgametools.com/tutorials/14/resources/yellowBlock.json)
