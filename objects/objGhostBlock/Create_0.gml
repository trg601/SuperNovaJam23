event_inherited()

base_index = color * 2
imgIndex = base_index
mySprite = sprite_index
myMask = mask_index

isSolid = startSolid

if !isSolid {
	isSolid = !isSolid
	event_user(0)
}