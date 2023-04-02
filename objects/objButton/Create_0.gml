event_inherited();

isPressed = false

base_index = color * 2
image_index = base_index

isSideButton = false
if image_yscale == -1 {
	image_yscale = 1
	image_angle = 360 - image_angle
}
if image_angle > 45 && image_angle < 315 {
	isSideButton = true
	mask_index = sprSpitObjectMask
}