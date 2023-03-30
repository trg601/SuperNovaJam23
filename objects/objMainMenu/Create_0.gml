menu = new Menu()
menu.addButton(new Button("Play", function() {
	room = RoomA
}))
menu.addButton(new Button("Toggle fullscreen", function() {
	window_set_fullscreen(!window_get_fullscreen())
    controlResize()
}))
menu.addButton(new Button("Quit", function() {
	game_end()	
}))