//Create new layer to put player and other objects in front
foregroundLayer = layer_create(-100, "Foreground")
behindLayer = layer_create(150, "Behind") //Goes behind tiles
backgroundLayer = layer_create(175, "BackgroundI")
guiLayer = layer_create(-500, "GuiLayer")
layer_add_instance(guiLayer, self)

with(objPlayer) layer_add_instance(other.foregroundLayer, self)
with(objCandy) layer_add_instance(other.foregroundLayer, self)

//Background objects
if instance_exists(objPlayer) {
	instance_create_layer(0, 0, "BackgroundI", objParallaxBG)
	switchMusic(musicTheme)
	window_set_cursor(cr_none)
} else {
	switchMusic(musicPause)
	cursor_sprite = -1
	window_set_cursor(cr_default)
}
with(objGrate) layer_add_instance(other.behindLayer, self)

//Assign particle system to new layer
part_system_layer(global.particleSystem, foregroundLayer)
part_particles_clear(global.particleSystem)

//Create camera
instance_create_layer(0, 0, "Instances", objCamera)

//Set up splatter tiles
if layer_exists("Tiles_1") {

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

}

pauseMenu.reset()

alarm[1] = 50
showTitle = false
if room != roomPrevious || global.forceRestart {
	//Check if we are in a defined level
	var size = ds_list_size(levels)
	for (var i = 0; i < size; i++) {
		var lvl = levels[| i]
		if lvl.room = room {
			curLevelTitle = lvl.name
			alarm[1] = 75
			showTitle = true
			nextLevel = i < numStoryLevels - 1 ? levels[| i+1].room : RoomMainMenu
			break
		}
	}
	
	global.playerLastX = -1
	global.playerLastY = -1
	global.playerCandyRemaining = -1
	ds_list_clear(global.playerCandyList)
	
	//Statistics
	if !global.forceRestart {
		timeRoomStarted = current_time
		restartsInRoom = 0
	}
	
	global.forceRestart = false
} else restartsInRoom++

with(objPlayer) event_user(0)
	
roomPrevious = room