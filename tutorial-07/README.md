NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/00-making-your-first-map/)

## 07 – Making Objects Physical
Difficulty: Beginner

Duration: 20 minutes

Description:

In a previous tutorial we saw how easy it was to add physics to our tiles which was great for a lot of things however it would be horribly inefficient to creat our whole world out of hundreds of small physical objects. To resolve this we will instead use an Objects width and height properties to create large physical blocks that we can draw over our visual world.

### Step 1: Getting your map

To make things simpler we are going to use the same map that we created in the first physics tutorial as well as knowledge we learnt in the object tutorial, so if you havent already done that these tutorials please do them now.

If you run this map now you will remember that we have a simple tile falling due to gravity and that it doesn’t get stopped by any platforms. We will now fix this.

### Step 2: Creating your platform object

Just like in the object tutorial we now need to create an object, only this time we are going to also set its width and height. You can do this two ways, first by manually setting the values in the Property window and secondly by actually resizing the object with your mouse.

![Set Size](http://lime.outlawgametools.com/tutorials/7/images/setSize.jpg)

Try to position it over the first platform in our map such as this:

![In Editor](http://lime.outlawgametools.com/tutorials/7/images/inEditor.jpg)

### Step 3: Giving it some properties

To make your object physical you will again need to give it some properties but you will also need to set its Type to Body:

![Body Type](http://lime.outlawgametools.com/tutorials/7/images/bodyType.jpg)

Running your game now you will not really notice anything different, this is because that although your platform object is indeed in game and physical it is also falling due to gravity, to fix this just set its bodyType property like this:

![Body Property](http://lime.outlawgametools.com/tutorials/7/images/bodyProperty.jpg)

### Step 4: Run your game

If you run your game now you will see that your tile falls and then gloriously comes to rest right on top of your platform, you may need to adjust your tiles bounce property to allow it to come to rest nicely.

![In Game](http://lime.outlawgametools.com/tutorials/7/images/complete.jpg)

Feel free to create physical objects for the rest of the platforms and remember that if you create some more of those red tiles you will have loads of falling tiles.

### Step 5: Setting up the physical world

Sometimes you or your level designer may want some more control over how the physical world is set up for a specific level, luckily this is nice and simple thanks to properties. This time we will add some new properties to our map itself, to do this select Map >> Map Properties….

Following are all the properties that you can set:

* Physics:GravityX _Sets the magnitude of gravity along the X axis._
* Physics:GravityY _Sets the magnitude of gravity along the Y axis._
* Physics:Scale _Sets the internal pixels-per-meter ratio that is used in converting between onscreen Corona coordinates and simulated physics coordinates [ from the Corona API ](http://docs.coronalabs.com/api/library/physics/setScale.html)._
* Physics:DrawMode _Sets the draw mode of the physics world, can be normal, debug or hybrid._
* Physics:PositionIterations _Sets the accuracy of the engine’s position calculations [ from the Corona API ](http://docs.coronalabs.com/api/library/physics/setPositionIterations.html)._
* Physics:VelocityIterations _Sets the accuracy of the engine’s velocity calculations [ from the Corona API ](http://docs.coronalabs.com/api/library/physics/setVelocityIterations.html)._


![Hybrid Draw Mode](http://lime.outlawgametools.com/tutorials/7/images/drawModeHybrid.png)

![Debug Draw Mode](http://lime.outlawgametools.com/tutorials/7/images/drawModeDebug.png)


### Step 6: A note about ramps

Some of you will have noticed that not everything in nature is a flat structure and that we actually have ramps of all gradients. This can still be achieved in your game through Lime however due to a missing feature in Tiled it can be a bit fiddly, to do it simply add a rotation property to your physical objects that correspond to your visual ramps.

The tricky part is that due to Tiled not being able to rotate objects you will have to use a bit of trial and error to get your objects in the right position and rotation. This is obviously annoying and I am currently looking into ways of improving this.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Tileset: [Download](http://lime.outlawgametools.com/tutorials/0/resources/tileset-platformer.png)

