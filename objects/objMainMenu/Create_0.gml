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
menuLevels.addButton(new Button("Level A", function() {
	room = RoomA
}))
menuLevels.addButton(new Button("Challenge Level", function() {
	room = RoomChallenge
}))
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
	audio_sound_gain(currentMusic, global.musicVolume, 50)
}))
menuOptions.addButton(new Button("Toggle sound", function() {
	global.soundVolume = global.soundVolume > 0 ? 0 : 1
}))
menuOptions.addButton(new Button("Back", function() {
	menu = menuMain
}))

menu = menuMain