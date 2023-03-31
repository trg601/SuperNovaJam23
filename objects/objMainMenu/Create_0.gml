menuMain = new Menu()
menuMain.addButton(new Button("Play", function() {
	room = RoomA
}))
menuMain.addButton(new Button("Levels", function() {
	menu = menuLevels
}))
menuMain.addButton(new Button("Options", function() {
	menu = menuOptions
}))
menuMain.addButton(new Button("Quit", function() {
	game_end()	
}))

menuLevels = new Menu()
var size = ds_list_size(objGame.levels)
for (var i = 0; i < size; i++) {
	var lvl = objGame.levels[| i]
	var btn = new Button(lvl.name, function(this) {room = this.room})
	btn.room = lvl.room
	menuLevels.addButton(btn)
}
menuLevels.addButton(new Button("Back", function() {
	menu = menuMain
}))

menuOptions = new Menu()
menuOptions.addButton(new Button("Toggle fullscreen", function() {
	window_set_fullscreen(!window_get_fullscreen())
    controlResize()
}))
menuOptions.addButton(new Button("Toggle music", function() {
	global.musicVolume = global.musicVolume > 0 ? 0 : 1
	audio_sound_gain(objGame.currentMusic, global.musicVolume, 50)
}))
menuOptions.addButton(new Button("Toggle sound", function() {
	global.soundVolume = global.soundVolume > 0 ? 0 : 1
}))
menuOptions.addButton(new Button("Back", function() {
	menu = menuMain
}))

menu = menuMain