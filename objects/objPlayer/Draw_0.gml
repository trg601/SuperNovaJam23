
if state == playerState.SWING {
	draw_line_textured(sprSpitRope, x, y, grappleX, grappleY)
	
	//Draw glob at end of rope
	var angle = 180
	if collision_point(grappleX + 20, grappleY + 5, objGrappleBlock, false, false) angle = 90
	else if collision_point(grappleX - 20, grappleY + 5, objGrappleBlock, false, false) angle = 270
	draw_sprite_ext(sprSpitObject, 0, grappleX, grappleY, 0.75, 0.75, angle, c_white, 1)
}

draw_sprite_ext(sprite_index, image_index, x + addX, y + addY, faceX * squishX, squishY, image_angle, image_blend, image_alpha)

image_blend = merge_color(c_white, spitChargeColor, spitCharge)

//Estimate projectile position
if spitCharge > spitChargeNecessaryToShoot {
	
	var xx = x, yy = y, time = 7, dir = point_direction(x, y, recticleX, recticleY)
	var mouseDist = min(point_distance(x, y, recticleX, recticleY) / 400, 1)
	if useGPRecticle
			mouseDist = min(point_distance(x, y, recticleX, recticleY) / (recticleDistance + recticleMinDistance), 1)
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

//Draw recticle
if recticleActive {
	draw_sprite(sprRecticle, 0, recticleX, recticleY)
	cursor_sprite = -1
}