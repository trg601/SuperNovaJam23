
onGround = false

if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1) {
	onGround = true
	alarm[0] = coyoteTime
	if ySpeed > 5 sprite_index = sprPlayerLand 
	ySpeed = 0
	
	if !place_meeting(x, y+1, objGhostBlock) {
		global.playerLastX = x
		global.playerLastY = y	
	}
}

//State handling
switch (state) {
case playerState.NORMAL: {

	if pressedJump && (onGround || alarm[0] > 0) {
		audio_play_sound(sndJump, 0, false, global.soundVolume / 4)
		ySpeed = jumpVelocity
		justJumped = true
		sprite_index = sprPlayerJumpStart
		image_index = 0
	}

	if justJumped && ySpeed < 0 && !holdJump{
		ySpeed*=0.90
	}

	if inputX != 0 { //accelerate x
		xSpeed += inputX * accelSpeed
		xSpeed = clamp(xSpeed, -moveSpeed, moveSpeed)
		
		if onGround && sprite_index == sprPlayerIdle sprite_index = sprPlayerWalk
	}
	else if xSpeed != 0{ //deaccelerate x
		var ts = sign(xSpeed)
		xSpeed -= ts * deaccelSpeed
		if (ts != sign(xSpeed)) {
			xSpeed = 0
			if onGround && sprite_index == sprPlayerWalk sprite_index = sprPlayerIdle
		}
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
			audio_play_sound(sndSpit, 0, false, global.soundVolume)
			sprite_index = sprPlayerSpit
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
			sprite_index = sprPlayerJumpStart
			image_index = 0
		}
	}
	
	if breakRope {
		audio_play_sound(sndSpit, 0, false, global.soundVolume)
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
if collideY {
	if ySpeed > 5 sprite_index = sprPlayerLand
	ySpeed = 0
}

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
	sprite_index = sprPlayerCharge
	image_index = spitCharge * 2
	
	if !holdSpit && spitCharge > spitChargeNecessaryToShoot {
		audio_play_sound(sndSpit, 0, false, global.soundVolume)
		var spit = instance_create_layer(x, y, "Foreground", objSpitProjectile)
		var dir = point_direction(x, y, recticleX, recticleY)
		var mouseDist = min(point_distance(x, y, recticleX, recticleY) / 400, 1)
		if useGPRecticle
			mouseDist = min(point_distance(x, y, recticleX, recticleY) / (recticleDistance + recticleMinDistance), 1)
		var dist = PROJECTILE_SPEED * spitCharge * mouseDist
		spit.xSpeed = lengthdir_x(dist, dir)
		spit.ySpeed = lengthdir_y(dist, dir)
		sprite_index = sprPlayerIdle
		spitCharge = 0
	}
} else if sprite_index == sprPlayerCharge {
	spitCharge = 0
	sprite_index = sprPlayerIdle
}

#endregion


if y > room_height {
	dead = true
	instance_destroy()
}
