
//Just quit the game quickly - Change later for pause/menu etc
if keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start) || togglePause {
	togglePause = false
	pauseMenu.reset()
	if gamepad_button_check_pressed(0, gp_start) pauseMenu.current = 0
	
	if keyboard_check(vk_shift) game_end()
	
	if !gamePaused {
		cursor_sprite = -1
		window_set_cursor(cr_default)
		if room == RoomMainMenu game_end()
		audio_sound_gain(global.currentMusic, global.musicVolume * 0.25, 50)
		
		instance_deactivate_all(true)
		instance_activate_object(objCamera)
		with(objCamera) gamePaused = true
		part_particles_clear(0)
		
		if sprite_exists(pauseSprite) sprite_delete(pauseSprite)
		pauseSprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), 0, 0, 0, 0)
		
	} else {
		window_set_cursor(cr_none)
		audio_sound_gain(global.currentMusic, global.musicVolume, 50)
		instance_activate_all()
		with(objCamera) gamePaused = false
		sprite_delete(pauseSprite)
		pauseSprite = -1
		if global.forceRestart room_restart()
		if roomTo != -1 {
			room = roomTo
			roomTo = -1
		}
		
	}
	
	gamePaused = !gamePaused
}

if gamePaused {
	
	var bWidth =  global.viewWidth / 4, bHeight = global.viewHeight / 8, padding = bHeight * 0.25
	var xx = global.viewWidth / 2, yy = global.viewHeight / 2 - (pauseMenu.length / 2) * (bHeight + padding)
	var leftX = xx - bWidth / 2, rightX = xx + bWidth / 2
	
	for (var i = 0; i < pauseMenu.length; i++) {
		pauseMenu.setButtonDimensions(i, leftX, yy, rightX, yy + bHeight)
		yy += bHeight + padding
	}
	pauseMenu.step(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))
}

if keyboard_check_pressed(ord("R")) {
	global.forceRestart = true
	room_restart()
}
