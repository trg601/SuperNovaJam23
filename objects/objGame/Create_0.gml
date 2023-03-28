//Makes compiler call the init function when the game is started, creating this object in rmInit
gml_pragma("global", "game_init()")
game_set_speed(60, gamespeed_fps)

//Go to start room (Signified by home icon)
room = global.roomGoto

//Global setup
global.freezeInput = false
global.worldGravity = 1 
global.terminalVelocity = 30
global.tileSize = 128

foregroundLayer = -1
sprTileLayer = -1

//Create dynamic sprites from tilemap
tile_sprite_map = ds_map_create()

function add_tileset_sprites(tileset_id, sprite_ind, tile_size=192) {
	var data = tileset_get_info(tileset_id)
	var list = ds_list_create()
	var imgWidth = sprite_get_width(sprite_ind)
	var surf = surface_create(imgWidth, sprite_get_height(sprite_ind))
	var org = (tile_size - data.tile_width) / 2
	surface_set_target(surf)
	draw_sprite(sprite_ind, 0, org, org)
	surface_reset_target()
	
	var xx = 0, yy = 0
	for(var i = 0; i < data.tile_count; i++) {
		if xx > imgWidth {
			xx = 0
			yy += tile_size
		}
		
		var spr = sprite_create_from_surface(surf, xx, yy, tile_size, tile_size, 0, 0, org, org)
		ds_list_add(list, spr)
		
		xx += tile_size
		
	}
	
	surface_free(surf)
	ds_map_add_list(tile_sprite_map, tileset_id, list)
}

add_tileset_sprites(tileset1, sprSplatterTileTest)