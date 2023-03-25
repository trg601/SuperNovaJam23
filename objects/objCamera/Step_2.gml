
if keyboard_check_pressed(vk_f11){
    window_set_fullscreen(!window_get_fullscreen())
    controlResize()
}


var dx = xto - x
if abs(dx) > 32 {
	x += dx/24
}

var dy = yto - y
if abs(dy) > 32 {
	y += dy/24
}

if (follow != noone) {
	x = lerp(x, follow.x, 0.4)
	y = lerp(y, follow.y, 0.4)
}

x = clamp(x, boundLeft, boundRight)
y = clamp(y, boundTop, boundBottom)

var vm = matrix_build_lookat(x, y, -1000, x, y, 0, 0, 1, 0)
camera_set_view_mat(camera, vm)