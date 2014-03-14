NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/04-more-info-on-tilesets/)

## 04 – More Info on Tilesets
Difficulty: Beginner

Duration: 10 minutes

Description:

Tilesets are obviously an important part of Tiled and Lime, in this tutorial we will show just how easy it is to work with them and reuse them in multiple maps.

### Step 1: Add your second tileset

Load up your map into Tiled just as before and go about adding another tileset just like you added the first one.

I have uploaded another tileset image that you can use [here](http://lime.outlawgametools.com/tutorials/4/resources/tileset-platformer-ice.png).

![TileSet Ice](http://lime.outlawgametools.com/tutorials/4/resources/tileset-platformer-ice.png)

### Step 2: Draw your new tiles

With your new tileset added you can now add new tiles from it just like the first one, try mixing stuff up to make things interesting. It looks pretty cold up in those clouds.

![New Tiles](http://lime.outlawgametools.com/tutorials/4/images/newTiles.jpg)

### Step 3: Exporting out your tileset

Imagine the situation; you’ve created a fantastic level that reaches the awesome heights of World 1-1, you’ve added loads of properties to your tiles and you are feeling really happy with your masterpiece. So happy in fact that you want to make a second level using the same tileset.

Do you recreate the tileset and all its properties in a second map file? _Time consuming_. What happens if you need to change a property in both tilesets? _Frustrating_. The solution? _Simple_.

####External tilesets.

By exporting your tilesets out to .tsx files you are able to reuse them in as many levels as you like and any required changes only need to be done once.

To export your tileset simply right click it and select _Export Tileset As..._ and select a suitable name. Your map is now using the external version. Or on the toolbar at the bottom of the Tileset pane click the document with right-arrow icon.


If you need to change any values just right click it again and select _Import Tileset_ and change away, remembering to export it out again once you have finished so all your maps get the desired changes.

To add an external tileset to a new map simply select Map >> Add External Tileset... and browse for your .tsx file.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`

Tileset: [Download](http://lime.outlawgametools.com/tutorials/4/resources/tileset-platformer-ice.png)
