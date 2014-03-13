NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/00-making-your-first-map/)

## 00 - Making Your First Map 
Difficulty
: Beginner

Duration
: 15 minutes

Description
: Being able to make a map in Tiled and load it up in Lime is the most important aspect and luckily it is very simple.

### Step 1: Download and install Tiled

Tiled is completely free and can be downloaded from [here](http://www.mapeditor.org/). Please note, I am not in any way connected to the developers of Tiled, if you experience a bug with it feel free to email me however don?t be suprised if I simply put you in contact with them.

After downloading the package simply install it like any other program and start it up.

### Step 2: Create a new map

Selecting File >> New? will bring up the following window:
[[http://lime.outlawgametools.com/tutorials/0/images/newMap.jpg|alt=New Map]]

Leave the Orientation as Orthogonal, while setting the Map Size to Width 15 and Height 10 and the Tile Size to Width 32 and Height 32.
Orthogonal maps are the easiest to create and are used for plenty of game types to keep you occupied at present. The Tile Size is measured in pixels while the Map Size is measured in tiles, so we are creating a map that is 480 wide pixels and 320 pixels high, one standard iPhone screen in landscape mode.

After clicking OK you should find your screen now looks something like this:

[[http://lime.outlawgametools.com/tutorials/0/images/emptyMap.jpg|alt=Empty Map]

### Step 3: Add a tileset

Tilesets are the building blocks of your map, in Corona they are implemented as sprite sheets. You can have as many tilesets as you like (and even external ones, which we will touch on in a later tutorial) all with different source images.

To get you started, here is a sample tileset provided by Kevin Hansen for use in these tutorials. Simply download it and save it in the root of your games directory.

To add one, simply select Map >> New Tileset? to bring up the following window:

[[http://lime.outlawgametools.com/tutorials/0/images/newTileset.jpg|alt=New Tileset]]
Now hit Browse? and select that file. Once selected make sure Tile Width and Tile Height are both 32 (measured in pixels) and both Margin and Spacing is set to 0. Now just hit the OK button.
When you have done this you will notice you have a new tileset located in the bottom right of Tiled.

[[http://lime.outlawgametools.com/tutorials/0/images/tileset.jpg|alt=Tileset in Tiled]]

### Step 4: Add your tiles

With your tileset loaded into Tiled your next step is to actually add your tiles, you do this by drawing them in. You have two brush types at your disposal, Stamp and Fill, for now simply leave it on Stamp like in the picture below.

[[http://lime.outlawgametools.com/tutorials/0/images/brushes.jpg|alt=Brushes]]

To draw a tile you first have to select it, to do so just tap it in the tileset and then just tap in the dotted grid to draw it.
Try creating a map that looks something like this:

[[http://lime.outlawgametools.com/tutorials/0/images/finishedMap.jpg|Finshed Map]]

### Step 5: Save the map

Once you are happy with your creation you should go ahead and save it, naturally you should be doing this often as per any computer work.

Before you save you must ensure your map will be in the correct format, currently Lime supports XML and CSV, to change the format select Tiled >> Preferences? to bring up the following window:

[[http://lime.outlawgametools.com/tutorials/0/images/preferences.jpg|alt=Preferences]]

On windows you'll need to select Map >> Map Properties and change the Layer Format drop down list. 

Simply ensure the data for tile layers is set to XML or CSV leaving all other settings as they are.
Now finally save your map via File >> Save, select a suitable name and choose your games root directory.

### Step 6: Load your map in Lime

The actual loading of your map is very simple, first off make sure you have actually placed the Lime folder in your games directory and then include the library as usual:

```
lime = require("lime.lime")
```

Note: the lime variable should be global as you see here, not local.

Now load up your map data:

```
local map = lime.loadMap("tutorial0.tmx")
```
 

After loading up your map you will not have any visual objects created, this allows you to load up multiple maps at once yet only creating the visual data later one at a time, to actually create the visual representation simply use the next line of code:

```
local visual = lime.createVisual(map)
```
[[http://lime.outlawgametools.com/tutorials/0/images/complete.jpg|alt=Complete]]

Please remember to update your orientation settings in your build.settings file as this map has been designed for landscape screens.

### Step 7: Bask in your awesomeness

Congratulations, you just made your first iPhone capable tile map! Does it give you a warm and fuzzy feeling inside? No? Then check out the second tutorial to add a bit more excitement to your map.

Resources:

Completed Project: The completed project is now available as part of your download after purchasing Lime.

Tileset: [Download](http://lime.outlawgametools.com/tutorials/0/resources/tileset-platformer.png)

