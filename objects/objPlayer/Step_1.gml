
//Input
inputX = 0
holdJump = false
holdSpit = false
pressedGrapple = false
pressedInteract = false
if !global.freezeInput {
	if keyboard_check(ord("D")) || keyboard_check(vk_right) inputX = 1
	if keyboard_check(ord("A")) || keyboard_check(vk_left) inputX = -1
	if abs(gamepad_axis_value(0, gp_axislh)) > gamepadAxisDeadZone {
		inputX = sign(gamepad_axis_value(0, gp_axislh))
		useGPRecticle = true
	}
	
	if keyboard_check(vk_space) || gamepad_button_check(0, gp_face1) || keyboard_check(vk_up)
		holdJump = true
	if mouse_check_button(mb_left) || gamepad_button_check(0, gp_shoulderl)
		holdSpit = true
	if mouse_check_button_released(mb_right) || gamepad_button_check_released(0, gp_shoulderr) || keyboard_check_released(ord("V"))
		pressedGrapple = true
	if keyboard_check(ord("E")) || gamepad_button_check(0, gp_face3)
		pressedInteract = true
	if keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1) || keyboard_check_pressed(vk_up) {
		pressedJump = true
		alarm[1] = jumpLeeway
	}
	
	//Choose whether to use gamepad or mouse for aiming
	recticleActive = false
	var mx = display_mouse_get_x(), my = display_mouse_get_y()
	if mx != mouse_xprev || my != mouse_yprev
		useGPRecticle = false
	else if abs(gamepad_axis_value(0, gp_axisrh)) > gamepadAxisDeadZone || abs(gamepad_axis_value(0, gp_axisrv)) > gamepadAxisDeadZone {
		useGPRecticle = true
		recticleActive = true
	}
	mouse_xprev = mx
	mouse_yprev = my
}

//Gamepad recticle
if recticleActive {
	var xx = gamepad_axis_value(0, gp_axisrh), yy = gamepad_axis_value(0, gp_axisrv)
	var dist = recticleMinDistance + point_distance(0, 0, xx, yy) * recticleDistance
	var dir = point_direction(0, 0, xx, yy)
	recticleX = x + lengthdir_x(dist, dir)
	recticleY = y + lengthdir_y(dist, dir)
} else {
	recticleX = mouse_x
	recticleY = mouse_y
}

cursor_sprite = useGPRecticle ? -1 : sprRecticle

addX = 0
addY = 0