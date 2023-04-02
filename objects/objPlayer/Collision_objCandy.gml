
ds_list_add(global.playerCandyList, {x: other.x + 64, y: other.startY + 64})
instance_destroy(other)
audio_play_sound(sndCollect, 0, false, global.soundVolume)
candyRemaining--