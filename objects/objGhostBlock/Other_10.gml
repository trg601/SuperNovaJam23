///@desc Switch state

isSolid = !isSolid
imgIndex = base_index + !isSolid
sprite_index = isSolid ? mySprite : -1
mask_index = isSolid ? myMask : -1
image_alpha = isSolid ? alphaSolid : alphaInvis

if isSolid {
	if place_meeting(x, y, objSpitObject)
		instance_destroy(instance_place(x, y, objSpitObject))
	if place_meeting(x, y, objPlayer) {
		var ins = instance_place(x, y, objPlayer)
		ins.dead = true
		instance_destroy(ins)
	}
}