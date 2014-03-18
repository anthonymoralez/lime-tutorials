lime-tutorials
==============

NOTE: These tutorials are based on [the originals at OutlawGameTools.com](http://lime.outlawgametools.com/tutorials-3/)
## Tutorials 
- [Tutorial 00 - Making Your First Map](tutorial-00)
- [Tutorial 01 - Using Layers to Create Depth](tutorial-01)
- [Tutorial 02 - Taking Advantage of Properties](tutorial-02)
- [Tutorial 03 - Building the Physical World](tutorial-03)
- [Tutorial 04 - More Info on TileSets](tutorial-04)
- [Tutorial 05 - Adding Life Through Animation](tutorial-05)
- [Tutorial 06 - Using Objects to Do Cool Stuff](tutorial-06)
- [Tutorial 07 - Making Objects Physical](tutorial-07)
- [Tutorial 08 - Complex Physics Objects](tutorial-08)
- [Tutorial 09 - Controling a Platformer Character's Jump](tutorial-09)
- [Tutorial 10 - More Work on Platformer Characters](tutorial-10)
- [Tutorial 11 - Animated Characters](tutorial-11)


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

Run it:

```bash 
cd lime-tutorials/tutorial-00
$CORONA_SDK/simulator main.lua
```

