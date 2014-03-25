NOTE: This tutorial is copied from [the original at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials/18-saving-space-with-map-formats/)

## 18 – Saving Space with Map Formats

Difficulty: Beginner

Duration: 5 minutes

Description:

Using a compressed map format can save you vital space, and it is also really simple to do.

### Step 1: Getting your map

For this tutorial I am going to use the map created in the first tutorial however you can use any you like.

### Step 2: Choosing a format

There are five different formats that Tiled, and thus Lime, supports. The regular XML format we have been using so far as well as CSV and three variants using Base64.

For now we are going to use ZLib however the process is the same for any of them, simply load up the Preferences window and then set the save format for Tile Layer data.

![ZLib Compressed](http://lime.outlawgametools.com/tutorials/18/images/zlib.png)

Now simply hit Close and then resave your map. You don’t need to change any code whatsoever. To see the difference just load up your map in a Text Editor and notice the change.

Resources:

Completed Project: `git clone https://github.com/anthonymoralez/lime-tutorials`
