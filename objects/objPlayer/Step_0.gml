
//Input
inputX = 0holdJump = false
holdSpit = false
if !global.freezeInput {
	if keyboard_check(ord("D")) inputX = 1
	if keyboard_check(ord("A")) inputX = -1
	if keyboard_check(vk_space) holdJump = true
	if mouse_check_button(mb_left) holdSpit = true
	if keyboard_check_pressed(vk_space) {
		pressedJump = true
		alarm[1] = jumpLeeway
	}
}

onGround = false

if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1) {
	onGround = true
	alarm[0] = coyoteTime
	ySpeed = 0
}

//State handling
switch (state) {
#region Normal Movement State
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
			var ins = instance_place(x + xSpeed, y - 15, parPushable);
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
	if mouse_check_button_released(mb_right) {
		state = playerState.SWING
		raycast = get_raycast(x, y, point_direction(x, y, mouse_x, mouse_y))
		if !is_undefined(raycast) {
			grappleX = raycast.x
			grappleY = raycast.y
			swingVelocity = 0
			swingAngle = point_direction(grappleX, grappleY, x, y)
			swingLength = point_distance(grappleX, grappleY, x, y)
			image_blend = c_white
		}
	}
	
} break
#endregion

#region Grapple/Swing State
case playerState.SWING: {
	onGround = false
	
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
	
	if inputX != 0 { //accelerate x
		swingVelocity += inputX * swingVelocityInputMod
	}
	
	if pressedJump {
		state = playerState.NORMAL
		ySpeed = jumpVelocity * 1.75
		justJumped = false
	}
	
} break
#endregion

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

if holdSpit || spitCharge > spitChargeNecessaryToShoot {
	if spitCharge == 0 spitCharge = 0.25
	spitCharge += spitChargeSpeed
	spitCharge = min(spitCharge, 1)
	
	if !holdSpit && spitCharge > spitChargeNecessaryToShoot {
		var spit = instance_create_layer(x, y, "Instances", objSpitProjectile)
		var dir = point_direction(x, y, mouse_x, mouse_y)
		spit.xSpeed = lengthdir_x(PROJECTILE_SPEED * spitCharge, dir)
		spit.ySpeed = lengthdir_y(PROJECTILE_SPEED * spitCharge, dir)
		spitCharge = 0
	}
} else spitCharge = 0

#endregion
