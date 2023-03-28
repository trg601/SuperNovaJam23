
collideY = false
if effectedByGravity {
	if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1) {
		ySpeed = 0
	} else {
		ySpeed += global.worldGravity
		ySpeed = min(ySpeed, global.terminalVelocity)
	
		collideY = place_move_y(ySpeed)
	}
}