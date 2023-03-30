
pauseMenuMain.cleanup()
pauseMenuOptions.cleanup()

if sprite_exists(pauseSprite) sprite_delete(pauseSprite)

part_type_destroy(global.partBubblePop)

part_system_destroy(global.particleSystem)

var key = ds_map_find_first(tile_sprite_map)
repeat (ds_map_size(tile_sprite_map)) {
	
	var list = tile_sprite_map[? key]
	var sz = ds_list_size(list)
	
	for (var i = 0; i < sz; i++) {
		sprite_delete(list[| i])	
	}
	
	ds_list_destroy(list)
	key = ds_map_find_next(tile_sprite_map, key)	
}

ds_map_destroy(tile_sprite_map)