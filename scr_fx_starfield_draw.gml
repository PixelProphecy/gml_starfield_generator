function scr_fx_starfield_draw(surf_starfield){
	if surface_exists(surf_starfield)
	    {
	      gpu_set_blendmode(bm_add);
	      draw_surface(surf_starfield,0,0)
	      gpu_set_blendmode(bm_normal);
	    };
}