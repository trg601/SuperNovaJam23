if ySpeed < 0
	ySpeed = other.globBounceForce * 0.5
else {
	var jumpFactor = max(abs(ySpeed) / global.terminalVelocity, 0.6)
	ySpeed = -other.globBounceForce * jumpFactor
		
	var angle = other.angle
	if (angle == 90 || angle == -90) && abs(x - other.x) < 40
		angle = 0
	xSpeed = 0.5 * jumpFactor * lengthdir_x(other.globBounceForce, angle + 90)
}