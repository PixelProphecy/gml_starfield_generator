# gml_starfield_generator
A script to generate starfields in GameMaker’s GML language.

## Overview
Since I found drawing starfields in Photoshop and importing them into GM a waste of texture-page space, I created this little script that creates starfields from scratch onto a transparent surface which can be drawn onto any background. The script is highly customizable and extensively commented so it should be fairly easy to use and modify.

## Usage
1. Download the two provided GML files
2. Import the two files as scripts into your Game Maker project
3. Create a new object
4. Add a Creation event with an "Execute Script" action and select `scr_fx_starfield_init`
5. Add a Draw event, also with an "Execute Script" action and select `scr_fx_starfield_draw`

To create a new starfield, just create an instance of the object at any coordinates.

## Notes
Since the starfield is drawn onto a surface that is inherently volatile, it's good practice to check whether it still exists and re-draw it, if necessary. Surfaces get destroyed when switching to/from full screen, for example. 
