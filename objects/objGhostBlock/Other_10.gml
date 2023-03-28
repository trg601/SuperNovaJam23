///@desc Switch state

isSolid = !isSolid
imgIndex = base_index + !isSolid
sprite_index = isSolid ? mySprite : -1
mask_index = isSolid ? myMask : -1

if isSolid && place_meeting(x, y, objSpitObject)
	instance_destroy(instance_place(x, y, objSpitObject))