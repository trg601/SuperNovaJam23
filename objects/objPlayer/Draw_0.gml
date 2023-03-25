
image_xscale = faceX * squishX
image_yscale = squishY
draw_self()
image_xscale = 1
image_yscale = 1

image_blend = merge_color(c_white, c_blue, spitCharge)

//Estimate projectile position
if spitCharge > spitChargeNecessaryToShoot {
	
	var xx = x, yy = y, time = 7, dir = point_direction(x, y, mouse_x, mouse_y)
	var xspd = lengthdir_x(PROJECTILE_SPEED * spitCharge, dir)
	var yspd = lengthdir_y(PROJECTILE_SPEED * spitCharge, dir)
	var npoints = round(spitCharge * 10)
	
	repeat(npoints) {
		xx += xspd * time
		yspd += (global.worldGravity * PROJECTILE_GRAVITY_MOD) * time
		yy += yspd * time
		draw_circle(xx, yy, 5, 0)
	}
	
}