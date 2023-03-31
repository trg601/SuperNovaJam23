event_inherited()

x = -x
var objOnTop = place_meeting(-x, y - 1, objSpitObject) || place_meeting(-x, y - 1, objPlayer)
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