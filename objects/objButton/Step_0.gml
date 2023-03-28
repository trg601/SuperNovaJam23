event_inherited()

x = -x
var objOnTop = place_meeting(-x, y - 1, objSpitObject)
x = -x

if isPressed != objOnTop {
	isPressed = objOnTop
	image_index = base_index + isPressed
	
	//Update ghost blocks
	with (objGhostBlock) {
		if color == other.color event_user(0)	
	}
}