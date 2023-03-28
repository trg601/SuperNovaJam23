
if state == playerState.SWING {
	draw_line_textured(sprSpitRope, x, y, grappleX, grappleY)
}

image_xscale = faceX * squishX
image_yscale = squishY
draw_self()
image_xscale = 1
image_yscale = 1

image_blend = merge_color(c_white, c_blue, spitCharge)

//Estimate projectile position
if spitCharge > spitChargeNecessaryToShoot {
	
	var xx = x, yy = y, time = 7, dir = point_direction(x, y, mouse_x, mouse_y)
	var mouseDist = min(point_distance(x, y, mouse_x, mouse_y) / 400, 1)
	var dist = PROJECTILE_SPEED * spitCharge * mouseDist
	var xspd = lengthdir_x(dist, dir)
	var yspd = lengthdir_y(dist, dir)
	var npoints = round(spitCharge * 10)
	
	with(objGrate) x = -x
	repeat(npoints) {
		xx += xspd * time
		yspd += (global.worldGravity * PROJECTILE_GRAVITY_MOD) * time
		yy += yspd * time
		if place_meeting(xx, yy, parSolid) break
		draw_circle(xx, yy, 5, 0)
	}
	with(objGrate) x = -x
	
}