# gml_starfield_generator
A script to generate starfields in GameMaker’s GML language.

![ScreenShot](https://raw.github.com/PixelProphecy/_images/gh-pages/gml_starfield_generator_screen_1.png)

## Overview
Since I found drawing starfields in Photoshop and importing them into GM a waste of texture-page space, I created this little script that creates starfields from scratch onto a transparent surface which can be drawn onto any background. The script is highly customizable and extensively commented so it should be fairly easy to use and modify.

## Usage
1. Download the two provided GML files
2. Import the two files as scripts into your Game Maker project
3. Create a new object
4. Add a Creation event and type the following in it: 

        madestars = false;
        starsprite = undefined;
        surf_starfield = -1; //do not use anything but -1 for surface variables

5. Add a Draw event then type the folling:

        if (madestars == false) {
        //make the star surface
        if(surf_starfield == -1){
                surf_starfield = scr_fx_starfield_init(surf_starfield)
        }
        starsprite = sprite_create_from_surface(surf_starfield, 0,0, room_width,room_height, false, false, 0,0);
        surface_free(surf_starfield);
        madestars = true;
        }

        gpu_set_blendmode(bm_add);
        draw_sprite(starsprite, 0, 0, 0);
        gpu_set_blendmode(bm_normal);

6. In the Destory event add this:

        if (sprite_exists(starsprite)) {
        sprite_delete(starsprite);
        }
6. Modify the values in `scr_fx_starfield_init` to your needs.

To create a new starfield, just create an instance of the object at any coordinates.

## Notes
Since the starfield is drawn onto a surface that is inherently volatile, it’s good practice to check whether it still exists and re-draw it, if necessary. Surfaces get destroyed when switching to/from full screen, for example.
