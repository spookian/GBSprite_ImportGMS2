// Creates and returns a surface from a game boy game, assuming the file has been loaded.
function create_surface_from_gb_tile(file)
{
	size = 4 * 8 * 8;
	var sprite_buffer = buffer_create(size, buffer_fast, 1);
	if (!buffer_exists(sprite_buffer)) return -1;

	buffer_seek(sprite_buffer, buffer_seek_start, 0);
	//you must seek the file yourself if it interferes with anything, but I will not seek the file due to this being able to load gameboy roms

	for(var i = 0; i < 8; i++)
	{
		var line_x = file_bin_read_byte(file); // first
		var line_y = file_bin_read_byte(file); //second
		for (var j = 0; j < 8; j++)
		{
			var pixel_x = line_x & (128 >> j);
			pixel_x = pixel_x >> (7-j);
		
			var pixel_y = line_y & (128 >> j);
			pixel_y = (pixel_y >> (7-j)) << 1;
			
			var current_pixel = pixel_x + pixel_y; //fix, shift bits so = 1
		
			var pixel_color = get_gb_sprite_palette(current_pixel);
		
			if (buffer_write(sprite_buffer, buffer_u8, (pixel_color >> 24) & $FF) == -1) game_end();
			if (buffer_write(sprite_buffer, buffer_u8, (pixel_color >> 16) & $FF) == -1) game_end();
			if (buffer_write(sprite_buffer, buffer_u8, (pixel_color >> 8) & $FF) == -1) game_end();
			if (buffer_write(sprite_buffer, buffer_u8, (pixel_color >> 0) & $FF) == -1) game_end();
		}
	}

	var sprite_surface = surface_create(8, 8);
	buffer_seek(sprite_buffer, buffer_seek_start, 0);
	buffer_set_surface(sprite_buffer, sprite_surface, 0);

	buffer_delete(sprite_buffer); 
	return sprite_surface;
}

/* There are several ways to get around the "gb object" problem.
* 1. Load all of the tiles you need into a buffer that acts as the game boy's VRAM, load the object data from the rom,
* ...write the buffer to a surface and grab the texture from the newly created surface to function as the level/room's vram. (I like and recommend this idea)
* Problem: surfaces are a hassle to deal with, but the vram buffer should hold. Also tileset functions are very barebones, so they will be unable to be used.

* 2. Assemble the tiles into a buffer using object data and sprite data and then create a sprite with it. (not recommended, unknown amount of sprites due
* ...to Game Maker's surface to sprite function not supporting animations.
* Problem: Literally everything with this solution