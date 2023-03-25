
ySpeed += global.worldGravity * PROJECTILE_GRAVITY_MOD

if place_meeting(x + xSpeed, y + ySpeed, parSolid) || (ySpeed > 0 && place_meeting_platform(xSpeed, ySpeed)) {
	//Create spit object
	var dir = point_direction(xSpeed, ySpeed, 0, 0)
	var dist = ceil(point_distance(0, 0, xSpeed, ySpeed))
	var ldir_x = lengthdir_x(1, dir)
	var ldir_y = lengthdir_y(1, dir)
	
	if instance_number(objSpitObject) > 2 instance_destroy(instance_find(objSpitObject, 0))
	var ins = instance_create_layer(x, y, "Instances", objSpitObject)
	
	with(ins) {
		repeat(dist) {
			if place_meeting(x + ldir_x, y + ldir_y, parSolid) || (ldir_y > 0 && place_meeting(x + ldir_x, y + ldir_y, parPlatform)) {
				x += ldir_x
				y += ldir_y
			} else break
		}
	}
	
	instance_destroy()
}

x += xSpeed
y += ySpeed

image_angle = point_direction(xprevious, yprevious, x, y)

if y > room_height instance_destroy()