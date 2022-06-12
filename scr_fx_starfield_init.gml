/*********************************************************************************************

    Starfield 1.1 by Phil Strahl (phil/at/pixelprophecy/dot/com)
    ---------------------------------------------------
    
    This script generates a starfield onto a surface. The script scr_fx_starfield_draw
    is used to draw the surface onto a background.
    
    MIT Licence
    Copyright 2016-2019 Phil Strahl.

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*********************************************************************************************/

// --- SETUP ---------------------------------------------------
function scr_fx_starfield_init(surf_starfield){    
  
    var surface_width          = room_width;  // set the surface width here    
    var surface_height         = room_height; // set the surface height here
 
    var stars_small_radius     = 1;           // radius in pixels for small stars
    var stars_small            = 1000;        // count of small stars

    var stars_medium_radius    = 2;           // radius in pixels for bigger stars    
    var stars_medium           = stars_small / 8; // count of medium sized stars

    var stars_big_radius       = 8;           // radius in pixels for big stars    
    var stars_big_have_shape   = true;        // if true, a little plus-shape will be drawn at the center of each big star. Looks best starting from sizes 10 and up    
    var stars_big              = stars_small / 300; // count of big stars

    var stars_color_inner      = c_white;     // color of star center (usually white)
    var stars_color_outer      = c_blue;      // color of star edge (usually darker when it should look nice)
    
    depth                      = 100000;      // sets the layer depth, so the stars are in your background
    
    randomize(); // = each run a new randomness. deactivate or use seeds if you want reproducable results
    
    // New in version 1.1
    var stars_size_fluctuation    =   .5;       // amount of star size to randomize, 0 to disable. E.g. 0.5 means stars end up between 50% and 150% their default size
    var star_clumping_probability =   .85;      // between 0 to 1, where 1 = all the smalls stars are in one clump, 0 = completely random
    var star_clumping_distance    = 40;         // neighborhood in pixels in which stars will be created when they clump

// -------------------------------------------------------------
    
    surf_starfield = 0;  // initializes starfield surface variable
    
    prev_x = 0;  // initializes previous coordinates for clumping
    prev_y = 0;
    
    // creates a new surface with the given dimensions

       surf_starfield = surface_create(surface_width, surface_height);
       surface_set_target(surf_starfield);
       draw_clear_alpha(c_black, 0);
       
       var i, starsize;
       
       // draws the small stars
       for (i=0; i <= stars_small; i++)
       {   
          // changing star size randomly
          if (stars_size_fluctuation != 0)
          {
           starsize = (stars_small_radius - (stars_small_radius * stars_size_fluctuation)) + (stars_small_radius * random(stars_size_fluctuation * 2));
          }
          else
          {
            starsize = stars_small_radius;
          }
          
          { // CLUMPING
              // if a random value between 0 and 1 is smaller than the clumping threshold
              if (random(1) <= star_clumping_probability)
              {
                // then create it in proximity to the previous star
                this_x = prev_x - star_clumping_distance + (random(star_clumping_distance) * 2);
                this_y = prev_y - star_clumping_distance + (random(star_clumping_distance) * 2);
              }
              else
              {
                // or use random values instead
                this_x = random(surface_width);
                this_y = random(surface_height);
              }
          } // end of clumping
          
          // storing values;
          prev_x = this_x;
          prev_y = this_y;
       
          // drawing the stars           
          draw_circle_color(this_x,
                            this_y,
                            starsize,
                            stars_color_inner,
                            stars_color_outer,
                            false);
       } // end of "draw small stars"
       
       // draws medium stars
       for (i = 0; i <= stars_medium; i++)
       {   
          if (stars_size_fluctuation != 0)
          {
           starsize = (stars_medium_radius - (stars_medium_radius * stars_size_fluctuation)) + (stars_medium_radius * random(stars_size_fluctuation * 2));
          }
          else
          {
            starsize = stars_medium_radius;
          }
          
          // use random values instead
          this_x = random(surface_width);
          this_y = random(surface_height);
            
          draw_circle_color(this_x,
                            this_y,
                            starsize,
                            stars_color_inner,
                            stars_color_outer,
                            false);
       }
       
       // draws big stars
       for (i = 0; i <= stars_big; i++)
       {
          if (stars_size_fluctuation != 0)
          {
           starsize = (stars_big_radius - (stars_big_radius * stars_size_fluctuation)) + (stars_big_radius * random(stars_size_fluctuation * 2));
          }
          else
          {
            starsize = stars_big_radius;
          }
          
          var star_big_x = random(surface_width);
          var star_big_y = random(surface_height);
                  
          // draw stars
          draw_circle_color(star_big_x,
                            star_big_y,
                            stars_big_radius,
                            stars_color_inner,
                            stars_color_outer,
                            false);
                            
          // draw the plus-shape on top
          if (stars_big_have_shape)
          {
            var shape_width = round(stars_big_radius / 2);
            var length      = 4; // factor of star-size radius to multiply shape size with

            // top stroke                                  
            draw_triangle_color(  star_big_x - shape_width/2, star_big_y,
                                  star_big_x + shape_width/2, star_big_y,
                                  star_big_x                , star_big_y - (stars_big_radius * length),
                                  stars_color_inner,
                                  stars_color_inner,
                                  stars_color_outer,
                                  false);
            // bottom stroke                                  
            draw_triangle_color(  star_big_x - shape_width/2, star_big_y,
                                  star_big_x + shape_width/2, star_big_y,
                                  star_big_x                , star_big_y + (stars_big_radius * length),
                                  stars_color_inner,
                                  stars_color_inner,
                                  stars_color_outer,
                                  false);
                                  
            // left stroke                                  
            draw_triangle_color(  star_big_x                              , star_big_y - shape_width/2,
                                  star_big_x                              , star_big_y + shape_width/2,
                                  star_big_x - (stars_big_radius * length), star_big_y ,
                                  stars_color_inner,
                                  stars_color_inner,
                                  stars_color_outer,
                                  false);
                                  
            // right stroke                                  
            draw_triangle_color(  star_big_x                              , star_big_y - shape_width/2,
                                  star_big_x                              , star_big_y + shape_width/2,
                                  star_big_x + (stars_big_radius * length), star_big_y ,
                                  stars_color_inner,
                                  stars_color_inner,
                                  stars_color_outer,
                                  false);
          }           
       } // end of drawing big stars for-loop
       
       // ends drawing to this surface
       surface_reset_target();
       

  return surf_starfield
}