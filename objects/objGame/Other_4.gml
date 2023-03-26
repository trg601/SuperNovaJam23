///@desc Manipulate splatter tiles

var lay_id = layer_get_id("Tiles_1")
var map_id = layer_tilemap_get_id(lay_id)
var tileset_id = tilemap_get_tileset(map_id)
var tileList = tile_sprite_map[? tileset_id]

sprTileLayer = layer_create(110, "tileAssetLayer")

var rw = ceil(room_width / global.tileSize), rh = ceil(room_height / global.tileSize)
for (var i = 0; i < rw; i++) {
	for (var j = 0; j < rh; j++) {
		var data = tilemap_get(map_id, i, j)
		var ind = tile_get_index(data)
		
		if (ind > 0) {
			layer_sprite_create(sprTileLayer, i * global.tileSize, j * global.tileSize, tileList[| ind])
			//tilemap_set(map_id, 0, i, j)
		}
	}
}