
if !onGround && ySpeed != 0 { //Bounce off
	justJumped = true
	kxSpeed = 0.5 * lengthdir_x(globBounceForce, other.angle + 90)
	ySpeed = -globBounceForce
	if bbox_bottom > other.bbox_bottom ySpeed = globBounceForce
}