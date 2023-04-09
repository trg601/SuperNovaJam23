
if image_index == 1 exit

with(objCheckpoint) {
	image_index = 0	
}

image_index = 1
global.playerLastX = other.x
global.playerLastY = other.y

audio_play_sound(sndActivateMush, 0, false, global.soundVolume, 0, 2)
