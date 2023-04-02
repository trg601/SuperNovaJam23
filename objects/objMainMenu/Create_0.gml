menuMain = new Menu()
menuMain.addButton(new Button("", function() {
	room = RoomTutorial
}, sprBtnPlay))
menuMain.addButton(new Button("", function() {
	menu = menuLevels
}, sprBtnLevels))
menuMain.addButton(new Button("", function() {
	menu = menuOptions
}, sprBtnOptions))
menuMain.addButton(new Button("", function() {
	game_end()	
}, sprBtnQuit))

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
menuOptions.addButton(new Button(global.musicVolume > 0 ? "Music: On" : "Music: Off", function(this) {
	global.musicVolume = global.musicVolume > 0 ? 0 : 1
	audio_sound_gain(global.currentMusic, global.musicVolume, 50)
	this.text = global.musicVolume > 0 ? "Music: On" : "Music: Off"
}))
menuOptions.addButton(new Button(global.soundVolume > 0 ? "Sound: On" : "Sound: Off", function(this) {
	global.soundVolume = global.soundVolume > 0 ? 0 : 1
	this.text = global.soundVolume > 0 ? "Sound: On" : "Sound: Off"
}))
menuOptions.addButton(new Button("View credits", function() {
	room = RoomCredits
}))
menuOptions.addButton(new Button("Back", function() {
	menu = menuMain
}))

menu = menuMain