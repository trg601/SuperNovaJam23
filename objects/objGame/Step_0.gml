
//Just quit the game quickly - Change later for pause/menu etc
if keyboard_check_pressed(vk_escape) {
	game_end()	
}

if keyboard_check_pressed(ord("R")) {
	room_restart()	
}
