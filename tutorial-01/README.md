NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/01-using-layers-to-create-depth/)

## 01 – Using Layers to Create Depth
Difficulty : Beginner

Duration : 10 minutes

Description:

In the previous tutorial we created a simple map which worked fine for our needs and looked great on screen yet underneath the hood there is a problem; every Corona display object is on the save level which can cause problems when playing a game because you want your player to be able to go behind certain things and in front of others. Don’t worry though as the solution to this is simple.

### Step 1: Load your map into Tiled

Firstly start up Tiled and File >> Open to load up the map we created in the previous tutorial.

### Step 2: Add a new layer

At first you will only have one layer in your map, this is what all your tiles have been added to so far. You can view this in the Layer panel to the right of Tiled:

![Layer Panel](http://lime.outlawgametools.com/tutorials/1/images/layerPanel.jpg)

Having just one layer is easy to manage but you will find that when your maps get more complicated it can get harder to deal with all the layers, luckily you can hide them by unticking them or change their opacity using the slider provided, please note though that these have no affect on your levels within Corona itself.

To add a new layer just right-click on the Layer panel and select Add Tile Layer..., object layers will be explained in a later tutorial. You will notice that you now have a new layer created and selected called "Tile Layer 2" that is currently above the first one. The higher the layer is in the list the higher its z-depth will be in Corona.

![New Layer](http://lime.outlawgametools.com/tutorials/1/images/newLayer.jpg)

### Step 3: Add some tiles to the layer

With your new layer created adding tiles is as simple as it was before, just make sure it is selected in the Layers panel and then start drawing your tiles.

Try adding some tiles with transparency to a position that has a tile on the first layer, such as this:

![Correct Layer](http://lime.outlawgametools.com/tutorials/1/images/correctLayer.jpg)

Notice that the tiles are placed nicely on top of the previous tiles without intefering with them. If you had added the new tiles to the first layer it would have looked like this:

![Wrong Layer](http://lime.outlawgametools.com/tutorials/1/images/wrongLayer.jpg)

### Step 4: Run your new map

Now everything is completed just load up the map in Corona as before and you’ll notice that the layering order has been preserved. Feel free to reorder your layers in Tiled to see what the differences are.

![Complete](http://lime.outlawgametools.com/tutorials/1/images/complete.jpg)

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

