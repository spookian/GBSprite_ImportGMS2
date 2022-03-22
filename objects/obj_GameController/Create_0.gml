/// @description I'm going to kill you.
file = 0;
palette = [gb_pixel.white, gb_pixel.l_grey, gb_pixel.d_grey, gb_pixel.black];
palettes = [palette]

var filename = get_open_filename("", "");
if (filename != "")
{
	file = file_bin_open(filename, 0);
}
//file_bin_seek(file, $AC4D);

var surf = create_surface_from_gb_tile(file);
var z = instance_create_depth(x, y, depth, obj_Mouse);
z.sprite_index = sprite_create_from_surface(surf, 0, 0, 8, 8, false, false, 0, 0);
z.safe = true;

surface_free(surf);
file_bin_close(file);
