
//Input
var inputX = 0, pressJump = false, holdSpit = false
if !global.freezeInput {
	if keyboard_check(ord("D")) inputX = 1
	if keyboard_check(ord("A")) inputX = -1
	if keyboard_check(vk_space) pressJump = true
	if mouse_check_button(mb_left) holdSpit = true
}

#region Movement
onGround = false

if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1) {
	onGround = true
	alarm[0] = coyoteTime
	ySpeed = 0
}

if pressJump && (onGround || alarm[0] > 0) {
	ySpeed = jumpVelocity
	justJumped = true
}

if justJumped && ySpeed < 0 && !pressJump{
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
	if place_meeting(x + xSpeed, y, parPushable) {
		//Push object
		var ins = instance_place(x + xSpeed, y, parPushable);
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

//Face
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
var collide = place_move_x((xSpeed + kxSpeed) * speedMod, onGround)
if collide && kxSpeed != 0 kxSpeed = -kxSpeed * 0.3
if place_move_y(ySpeed) ySpeed = 0
speedMod = 1

#endregion

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
