

if place_meeting(x, y+1, parSolid) || place_meeting_platform(0, 1) {
	ySpeed = 0
} else {
	ySpeed += global.worldGravity
	ySpeed = min(ySpeed, global.terminalVelocity)
	
	if place_move_y(ySpeed) event_user(0)
}

if keyboard_check(vk_enter) push_pushable_object(self, 10, true)