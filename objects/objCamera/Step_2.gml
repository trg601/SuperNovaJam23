
if keyboard_check_pressed(vk_f11){
    window_set_fullscreen(!window_get_fullscreen())
    controlResize()
}


var dx = xto - x
if abs(dx) > 10 {
	x += dx/12
}

var dy = yto - y
if abs(dy) > 10 {
	y += dy/12
}


if followPlayer {
	var player = objPlayer
	xto = player.x + (player.xSpeed + player.kxSpeed) * 2
	yto = player.y + player.ySpeed * 2
}

x = clamp(x, boundLeft, boundRight)
y = clamp(y, boundTop, boundBottom)

var vm = matrix_build_lookat(x, y, -1000, x, y, 0, 0, 1, 0)
camera_set_view_mat(camera, vm)