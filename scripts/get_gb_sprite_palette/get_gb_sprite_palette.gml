// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum gb_pixel
{
	black = $000000FF,
	d_grey = $555555FF,
	l_grey = $AAAAAAFF,
	white = $FFFFFFFF,
	transp = $FFFFFF00
}

function get_gb_sprite_palette(current_pixel)
{
	return palette[current_pixel];
} //store palette information inside of object instead?

//0xFFFFFFFF is white
//0xAAAAAAFF is light grey
//0x555555FF is dark grey
//0x000000FF is black

//