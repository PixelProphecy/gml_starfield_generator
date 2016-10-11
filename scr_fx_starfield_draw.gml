if surface_exists(surf_starfield)
    {
      draw_set_blend_mode(bm_add);
      draw_surface(surf_starfield,0,0)
      draw_set_blend_mode(bm_normal);
    };
