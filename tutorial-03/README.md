NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/03-building-the-physical-world/)

## 03 – Building the Physical World
Difficulty: Beginner

Duration: 10 minutes

Description:

Being able to include Coronas physics features in your map is both fun and easy, at the time of writing there are two ways to do so and more will be added at a later time.

This tutorial is going to deal with the first method, using tile properties just like we did in the [previous tutorial](../tutorial-02).

### Step 1: Creating your properties

The first thing you will need to do is decide which tile you want to add physics too, I have decided to use the little red brick tile. Now just bring up the Property window as before and add a HasBody property like this:

![Body Property](http://lime.outlawgametools.com/tutorials/3/images/bodyProperty.jpg)

This is the only property that you need to give this tile physics properties, now just add atleast one of those tiles into your map.

![Tile In Map](http://lime.outlawgametools.com/tutorials/3/images/tileInMap.jpg)

### Step 2: Building your world

If you ran your map now nothing new would happen apart from having a random red tile just floating there staring at you, what we need to do is build the world. This can be done in one line of code placed sometime after you have created your visual, like this:

`local physical = lime.buildPhysical(map)`

Now run your game and notice your new tile fall according to gravity, nice and simple. You will also notice that your tile will fall off the map and just keep going like the little trooper that it is, what we need is to add some collisions for those platforms. We will do this in a later tutorial after we have covered Objects.

What you can do now to have a play is add any Corona physics properties to your tile, like so:

![More Properties](http://lime.outlawgametools.com/tutorials/3/images/moreProperties.jpg)

Using the property of bodyType with the value of static on the platform tiles in your tileset you would be able to give the rest of your world some collision, however in a later tutorial we will see how this can be acomplished easier and more efficiently.

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
