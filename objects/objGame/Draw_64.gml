
//Crossfade start of level / show title
if alarm[1] != -1 {
	var val = alarm[1] / 50
	draw_set_color(c_black)
	draw_set_alpha(val)
	draw_rectangle(0, 0, global.viewWidth, global.viewHeight, false)
	draw_set_color(c_white)
	if showTitle {
		draw_set_font(fntDefault)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_text(global.viewWidth / 2, global.viewHeight / 2, curLevelTitle)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
	draw_set_alpha(1)
}

//Crossfade end of level
if alarm[0] != -1 {
	var val = 1 - (alarm[0] / 30)
	draw_set_color(c_black)
	draw_set_alpha(val)
	draw_rectangle(0, 0, global.viewWidth, global.viewHeight, false)
	draw_set_color(c_white)
	draw_set_alpha(1)
}

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