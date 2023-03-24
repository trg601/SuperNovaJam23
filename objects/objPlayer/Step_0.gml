
#region Movement
onGround = false

if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1, parPlatform) {
	onGround = true
	alarm[0] = coyoteTime
	ySpeed = 0
}

//Input
var inputX = 0, pressJump = false
if !global.freezeInput {
	if keyboard_check(ord("D")) inputX = 1
	if keyboard_check(ord("A")) inputX = -1
	if keyboard_check(vk_space) pressJump = true
}

if pressJump && (onGround || alarm[0] > 0) {
	ySpeed = jumpVelocity
}

if ySpeed < 0 && !pressJump{
	ySpeed*=0.90
}

if inputX != 0 { //acceleration x
	xSpeed += inputX * accelSpeed
	xSpeed = clamp(xSpeed, -moveSpeed, moveSpeed)
}
else { //deacceleration x
	if xSpeed != 0{
		var ts = sign(xSpeed)
		xSpeed -= ts * deaccelSpeed
		if (ts != sign(xSpeed)) then xSpeed = 0
	}
}

if !onGround {
	ySpeed += global.worldGravity
	ySpeed = min(ySpeed, terminalVelocity)
	
	if ySpeed < 0 && place_meeting(x, y-1, parSolid) ySpeed = 0
}

//Commit to movement
if xSpeed != 0 faceX = sign(xSpeed)
place_move_x(xSpeed, onGround)
place_move_y(ySpeed)

#endregion
