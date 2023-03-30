if gamePaused {
	if sprite_exists(pauseSprite) {
		var pauseSprScale = global.viewHeight / sprite_get_height(pauseSprite)
		draw_sprite_ext(pauseSprite, 0, 0, 0, pauseSprScale, pauseSprScale, 0, c_white, 1)
	} else draw_clear(c_dkgray)
	
	draw_set_color(c_black)
	draw_set_alpha(0.25)
	draw_rectangle(0, 0, global.viewWidth, global.viewHeight, 0)
	draw_set_color(c_white)
	draw_set_alpha(1)
	
	//Draw buttons
	pauseMenu.draw()
}