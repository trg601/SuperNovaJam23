function draw_line_textured(spr, x1, y1, x2, y2){
	var sW = sprite_get_width(spr), sH = sprite_get_height(spr)
	var angle = point_direction(x1, y1, x2, y2)
	var xx = x1, yy = y1, lx = lengthdir_x(sW, angle), ly = lengthdir_y(sW, angle)
	var segments = point_distance(x1, y1, x2, y2) div sW
	repeat (segments) {
		draw_sprite_ext(spr, 0, xx, yy, 1, 1, angle, c_white, 1)
		xx += lx
		yy += ly
	}
	var remainder = point_distance(xx, yy, x2, y2)
	lx = lengthdir_x(sprite_get_yoffset(spr), angle - 90)
	ly = lengthdir_y(sprite_get_yoffset(spr), angle - 90)
	draw_sprite_general(spr, 0, 0, 0, remainder, sH, xx - lx, yy - ly, 1, 1, angle, c_white, c_white, c_white, c_white, 1)

}