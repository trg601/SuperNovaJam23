
//Input
inputX = 0
holdJump = false
holdSpit = false
pressedGrapple = false
pressedInteract = false
if !global.freezeInput {
	if keyboard_check(ord("D")) inputX = 1
	if keyboard_check(ord("A")) inputX = -1
	if abs(gamepad_axis_value(0, gp_axislh)) > gamepadAxisDeadZone {
		inputX = sign(gamepad_axis_value(0, gp_axislh))
		useGPRecticle = true
	}
	
	if keyboard_check(vk_space) || gamepad_button_check(0, gp_face1)
		holdJump = true
	if mouse_check_button(mb_left) || gamepad_button_check(0, gp_shoulderl)
		holdSpit = true
	if mouse_check_button_released(mb_right) || gamepad_button_check_released(0, gp_shoulderr)
		pressedGrapple = true
	if keyboard_check(ord("E")) || gamepad_button_check(0, gp_face3)
		pressedInteract = true
	if keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1) {
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

onGround = false

if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1) {
	onGround = true
	alarm[0] = coyoteTime
	ySpeed = 0
}

//State handling
switch (state) {
case playerState.NORMAL: {

	if pressedJump && (onGround || alarm[0] > 0) {
		ySpeed = jumpVelocity
		justJumped = true
	}

	if justJumped && ySpeed < 0 && !holdJump{
		ySpeed*=0.90
	}

	if inputX != 0 { //accelerate x
		xSpeed += inputX * accelSpeed
		xSpeed = clamp(xSpeed, -moveSpeed, moveSpeed)
	}
	else if xSpeed != 0{ //deaccelerate x
		var ts = sign(xSpeed)
		xSpeed -= ts * deaccelSpeed
		if (ts != sign(xSpeed)) then xSpeed = 0
	}

	if onGround {
		if place_meeting(x + xSpeed, y - 15, parPushable) {
			//Push object
			var ins = instance_place(x + xSpeed, y - 15, parPushable)
			if ins.pushable && ((x < ins.bbox_left && xSpeed > 0) || (x > ins.bbox_right && xSpeed < 0)) {
				speedMod = push_pushable_object(ins, xSpeed, true)
			}
		}
	}
	else {
		ySpeed += global.worldGravity
		ySpeed = min(ySpeed, global.terminalVelocity)
	
		if ySpeed < 0 && place_meeting(x, y-1, parSolid) ySpeed = 0
	}
	
	//Enter grapple state
	if pressedGrapple && alarm[2] == -1 {
		var angle = point_direction(x, y, recticleX, recticleY)
		if useGPRecticle && !recticleActive
			angle = 90 - 45 * faceX
		
		with (objGrate) x = -x //move grate objects out of the level so they aren't effected by raycast
		var raycast = get_raycast(x, y, angle, 1500)
		var hitGrappleBlock = !is_undefined(raycast) && collision_circle(raycast.x, raycast.y, 5, objGrappleBlock, 0, 0)
		
		//Still grapple on if you miss it by some distance
		if !hitGrappleBlock && !is_undefined(raycast) {
			var nearest = instance_nearest(raycast.x, raycast.y, objGrappleBlock)
			var xx = nearest.bbox_left + (nearest.bbox_right - nearest.bbox_left) / 2
			var yy = nearest.bbox_bottom
			if point_distance(raycast.x, raycast.y, xx, yy) < 600 {
				raycast = get_raycast(x, y, point_direction(x, y, xx, yy), 1500)	
				hitGrappleBlock = !is_undefined(raycast) && collision_circle(raycast.x, raycast.y, 5, objGrappleBlock, 0, 0)
			}
		}
		with (objGrate) x = -x //put grate objects back in levela 
		
		if hitGrappleBlock && (angle < 225 || angle > 315) {
			alarm[2] = 30
			pressedGrapple = false
			state = playerState.SWING
			grappleX = raycast.x
			grappleY = raycast.y
			swingVelocity = 0
			swingLength = point_distance(grappleX, grappleY, x, y)
		}
	}
	
} break

case playerState.SWING: {
	
	swingAngle = point_direction(grappleX, grappleY, x, y)
	var angleAccel = -swingAccelSpeed * dcos(swingAngle)
	swingVelocity += angleAccel
	swingVelocity *= 0.99
	
	var tangent = swingAngle + 90 * sign(swingVelocity)
	var spd = min(abs(swingVelocity) * swingVelocityMod, global.terminalVelocity)
	xSpeed = lengthdir_x(spd, tangent)
	ySpeed = lengthdir_y(spd, tangent)
	
	var dist = point_distance(grappleX, grappleY, x, y)
	if dist > swingLength {
		var diff = dist - swingLength
		var angle = swingAngle + 180
		place_move_x(lengthdir_x(diff, angle))
		place_move_y(lengthdir_y(diff, angle))
	}
	
	var breakRope = false
	
	//break rope if conditions are met
	if swingLength < 100 || (swingAngle > 45 && swingAngle < 135)
		breakRope = true
	
	//accelerate x
	if inputX != 0
		swingVelocity += inputX * swingVelocityInputMod
	
	if pressedJump || pressedGrapple {
		breakRope = true
		if alarm[2] == -1 {
			var val = min(abs(angle_difference(swingAngle, 270)) / 60, 1)
			kxSpeed = clamp(xSpeed, -20, 20)
			xSpeed = 0
			ySpeed = val * swingJumpVelocity
			justJumped = false
		}
	}
	
	if breakRope {
		state = playerState.NORMAL
		var seg_length = 30
		var segments = dist div seg_length
		var angle = swingAngle
		var xx = grappleX, yy = grappleY
		var lx = lengthdir_x(seg_length, angle), ly = lengthdir_y(seg_length, angle)
		repeat (segments) {
			part_particles_create(global.particleSystem, xx, yy, global.partBubblePop, 5)
			xx += lx
			yy += ly
		}	
	}
	
} break

default: show_error("Unknown state!", true)
}

//Face direction
var xs = sign(xSpeed)
if xSpeed != 0 faceX = xs

//deaccelerate kinetic x speed
if kxSpeed != 0 {
	var kxs = sign(kxSpeed)
	var kdeaccelSpeed = (onGround || xs == -kxs) ? 0.5 : 0.1
	kxSpeed -= kxs * deaccelSpeed * kdeaccelSpeed
	if (kxs != sign(kxSpeed)) then kxSpeed = 0
}

//Commit to movement
var collideX = place_move_x((xSpeed + kxSpeed) * speedMod, onGround)
if collideX && kxSpeed != 0 kxSpeed = -kxSpeed * 0.3
var collideY = place_move_y(ySpeed)
if collideY ySpeed = 0

if state == playerState.SWING && (collideX || collideY) {
	swingAngle = point_direction(grappleX, grappleY, x, y)
	swingVelocity = 0
	kxSpeed = 0
	ySpeed = 0
}
speedMod = 1


#region Spittin

if (holdSpit || spitCharge > spitChargeNecessaryToShoot) && (!useGPRecticle || recticleActive) {
	if spitCharge == 0 spitCharge = 0.25
	spitCharge += spitChargeSpeed
	spitCharge = min(spitCharge, 1)
	
	if !holdSpit && spitCharge > spitChargeNecessaryToShoot {
		var spit = instance_create_layer(x, y, "Foreground", objSpitProjectile)
		var dir = point_direction(x, y, recticleX, recticleY)
		var mouseDist = min(point_distance(x, y, recticleX, recticleY) / 400, 1)
		if useGPRecticle
			mouseDist = min(point_distance(x, y, recticleX, recticleY) / (recticleDistance + recticleMinDistance), 1)
		var dist = PROJECTILE_SPEED * spitCharge * mouseDist
		spit.xSpeed = lengthdir_x(dist, dir)
		spit.ySpeed = lengthdir_y(dist, dir)
		spitCharge = 0
	}
} else spitCharge = 0

#endregion


if y > room_height {
	dead = true
	instance_destroy()
}