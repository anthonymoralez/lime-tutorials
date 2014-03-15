lime-tutorials
==============

NOTE: These tutorials are based on [the originals at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials-3/)
## Tutorials 
- [Tutorial 00 - Making Your First Map](tutorial-00)
- [Tutorial 01 - Using Layers to Create Depth](tutorial-01)
- [Tutorial 02 - Taking Advantage of Properties](tutorial-02)
- [Tutorial 03 - Building the Physical World](tutorial-03)
- [Tutorial 04 - More Info on TileSets](tutorial-04)


## Running the tutorial code
You need to have [The Corona SDK](http://coronalabs.com/)

Setup a tutorial project:

```bash
git clone https://github.com/anthonymoralez/Lime2DTileEngine.git #1
git clone https://github.com/anthonymoralez/lime-tutorials.git #2
cp -r Lime2DTileEngine/lime lime-tutorials/tutorial-00/lime #3
curl -o lime-tutorials/tutorial-00/sprite.lua https://raw.githubusercontent.com/coronalabs/framework-sprite-legacy/master/sprite.lua #4
```

1. Clone the lime repository 
2. Clone this repository. 
3. Copy the lime folder from the lime repository into the tutorial folder you'd like to run (e.g. [tutorial-00](tutorial-00)). 
4. Put the sprite.lua shim also in the tutorial folder 

Run it:

```bash 
cd lime-tutorials/tutorial-00
$CORONA_SDK/simulator main.lua
```

