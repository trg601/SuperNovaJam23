//Makes compiler call the init function when the game is started, creating this object in rmInit
gml_pragma("global", "game_init()")
game_set_speed(60, gamespeed_fps)

//Go to start room (Signified by home icon)
room = global.roomGoto
roomPrevious = room


//Global setup
global.freezeInput = false
global.worldGravity = 1 
global.terminalVelocity = 30
global.tileSize = 128
global.spitColor = make_color_rgb(71, 255, 231)

foregroundLayer = -1
backgroundLayer = -1
guiLayer = -1
sprTileLayer = -1
global.particleSystem  = part_system_create_layer("Instances", true)

#region Particle definition

//Bubble pop
var p = part_type_create()
part_type_shape(p, pt_shape_sphere)
part_type_size(p, 0.2, 0.5, -0.01, 0)
part_type_speed(p, 1, 3, 0, 0)
part_type_direction(p, 0, 360, 0, 0)
part_type_orientation(p, 0, 360, 0, 0, 0)
part_type_life(p, 15, 25)
part_type_color1(p, global.spitColor)
global.partBubblePop = p

//Player death
var p = part_type_create()
part_type_shape(p, pt_shape_sphere)
part_type_size(p, 0.7, 2, -0.05, 0)
part_type_speed(p, 1, 4, 0, 0)
part_type_direction(p, 0, 360, 0, 0)
part_type_orientation(p, 0, 360, 0, 0, 0)
part_type_life(p, 40, 50)
part_type_color1(p, global.spitColor)
global.partPlayerDeath = p


#endregion


//Music  
global.musicVolume = 1
global.soundVolume = 1
currentMusic = audio_play_sound(musicTheme, 10, true, global.musicVolume)

gamePaused = false
pauseSprite = -1
togglePause = false
pauseMenuMain = new Menu()
pauseMenuMain.addButton(new Button("Keep playing!", function() {
	togglePause = true
}))
pauseMenuMain.addButton(new Button("Restart level", function() {
	room_restart()
	togglePause = true
}))
pauseMenuMain.addButton(new Button("Options", function() {
	pauseMenu = pauseMenuOptions
}))
pauseMenuMain.addButton(new Button("Quit", function() {
	if room == RoomMainMenu game_end()
	else room = RoomMainMenu
	togglePause = true
}))

pauseMenuOptions = new Menu()
pauseMenuOptions.addButton(new Button("Back", function() {
	pauseMenu = pauseMenuMain
}))
pauseMenuOptions.addButton(new Button("Toggle fullscreen", function() {
	window_set_fullscreen(!window_get_fullscreen())
    controlResize()
}))
pauseMenuOptions.addButton(new Button("Toggle music", function() {
	global.musicVolume = global.musicVolume > 0 ? 0 : 1
	audio_sound_gain(currentMusic, global.musicVolume, 50)
}))
pauseMenuOptions.addButton(new Button("Toggle sound", function() {
	global.soundVolume = global.soundVolume > 0 ? 0 : 1
}))


pauseMenu = pauseMenuMain

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

add_tileset_sprites(tileset1, sprSplatterGooTileSet)