
if keyboard_check_pressed(vk_f11){
    window_set_fullscreen(!window_get_fullscreen())
    controlResize()
}

if !gamePaused {
	var dx = xto - x
	if abs(dx) > 5 {
		x += dx/12
	}

	var dy = yto - y
	if abs(dy) > 5 {
		y += dy/12
	}


	if followPlayer {
		var player = objPlayer
		var dist = player.useGPRecticle ? (player.recticleDistance + player.recticleMinDistance) : 400
		var rx = clamp((player.recticleX - player.x) / dist, -1, 1) * 50
		var ry = clamp((player.recticleY - player.y) / dist, -1, 1) * 50
		if player.useGPRecticle && !player.recticleActive {
			rx = 0
			ry = 0
		}
		xto = player.x + (player.xSpeed + player.kxSpeed) * 2 + rx
		yto = player.y + player.ySpeed * 2 + ry
	}

	x = clamp(x, boundLeft, boundRight)
	y = clamp(y, boundTop, boundBottom)
}

var vm = matrix_build_lookat(x, y, -1000, x, y, 0, 0, 1, 0)
camera_set_view_mat(camera, vm)