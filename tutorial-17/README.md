NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/17-adding-depth-with-parallax-scrolling/)

## 17 – Adding Depth with Parallax Scrolling

Difficulty: Beginner

Duration: 15 minutes

Description:

Parallax Scrolling is a very nice effect used in 2D platformer style games that helps give the illusion of depth, in this tutorial you will see how easy it is to set up in Lime. Please note that you need version 3.1 of Lime and there may still be teething issues.

### Step 1: Getting your map

To make things a little easier I have provided an already created map, there is nothing special about this map and currently there are no properties. It is simply just setup with a few different TileLayers.

### Step 2: Enabling parallax scrolling

Enabling parallax scrolling is simple, just add a “ParallaxEnabled” property to your map.

![Parallax Enabled Property](http://lime.outlawgametools.com/tutorials/17/images/mapProperty.png)

### Step 3: Adjusting each layers Parallax factor.

If you ran the game now you would see an awesome map, but that’s it. Even if you dragged the map or moved it any other way nothing exciting would happen, what you need to do is set up each layer for parallax. In this example we are only going to see horizontal scrolling however you will be able to vertical scrolling in your own maps aswell.

What you need to do is give each layer a “parallaxFactorX” property and an associated value. The parallax factor of a layer is essentially the speed it moves relative to the camera, you will want to use higher values for layers that are closer to the camera so they move fast and lower numbers for layers that are further away.

![Parallax Factor](http://lime.outlawgametools.com/tutorials/17/images/layerProperty.png)

If you don’t add a parallax factor to a layer it will move at the default speed, so you will probably want to leave it out for your main players layer which in this case is the “Platforms” layer.

For the provided map the values I have used are:

Foreground: 5
Background: 0.7
FarBackground: 0.5
Sky: 0.1

### Step 4: Setting the base layer

In order for Lime to properly clamp the camera to the map it needs to know what the base layer is, generally this will be the layer that your player is on so in this case it is the “Platforms” layer. In order to set the base layer simply add a “parallaxBase” property to your chosen tile layer.

![Parallax Base Layer](http://lime.outlawgametools.com/tutorials/17/images/parallaxBase.png)

If you don’t set a base layer Lime will automatically choose the one that is closest to the camera.

### Step 5: Adding the code

There actually isn’t any code required to use Parallax however you still will want some code just to show it off, for this we will just use some regular movement and dragging code.

Rather than having you copy and paste regular code I will make it easier for you and just link you to a completed “main.lua” file.

Note: You will want to disable screen culling by calling lime.disableScreenCulling() just after loading Lime.

![Completed Map](http://lime.outlawgametools.com/tutorials/17/images/complete.png)

It really is that simple. There are still some issues though, such as visible tearing when using the slideToPosition function. This seems to be an issue with Transitions as the issue isn’t noticeable when you simply drag the map. As usual you have to be careful with physics bodies by making sure they are, for now, all in the same layer.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Map: [Download](tutorial-17.tmx)

Tileset: [Download](http://lime.outlawgametools.com/tutorials/0/resources/tileset-platformer.png)
