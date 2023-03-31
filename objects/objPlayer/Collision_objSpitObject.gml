
if state == playerState.SWING {
	if x < other.x
		swingVelocity -= 5
	else
		swingVelocity += 5
}
else if !onGround { //Bounce off
	audio_play_sound(sndBounceGlob, 0, false, global.soundVolume)
	if bbox_bottom > other.bbox_bottom
		ySpeed = other.globBounceForce * 0.5
	else if ySpeed > 0 {
		sprite_index = sprPlayerJumpStart
		 image_index = 0
		justJumped = false
		var jumpFactor = max(abs(ySpeed) / global.terminalVelocity, 0.6)
		if pressedJump jumpFactor *= 1.5
		ySpeed = max(-other.globBounceForce * jumpFactor, maxBounceVelocity)
		
		var angle = other.angle
		if (angle == 90 || angle == -90) && abs(x - other.x) < 40
			angle = 0
		kxSpeed = 0.5 * jumpFactor * lengthdir_x(other.globBounceForce, angle + 90)
	}
}