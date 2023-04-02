event_inherited()

x = -x
var objOnTop = place_meeting(-x, y - 1, objSpitObject) || place_meeting(-x, y - 1, objPlayer)
if isSideButton {
	var xx = -x + lengthdir_x(5, image_angle + 90), yy = y + lengthdir_y(5, image_angle + 90)
	var objOnTop = place_meeting(xx, yy, objSpitObject)
	if objOnTop {
		var ins = instance_place(xx, yy, objSpitObject)
		ins.angle = image_angle
		ins.pushable = false
		ins.effectedByGravity = false
	}
}
x = -x

if isPressed != objOnTop {
	isPressed = objOnTop
	image_index = base_index + isPressed
	
	if alarm[0] == -1 {
		audio_play_sound(sndActivateMush, 0, false, global.soundVolume)
		alarm[0] = 10
	}
	
	//Update ghost blocks
	with (objGhostBlock) {
		if color == other.color event_user(0)	
	}
}