
with(objCamera) followPlayer = false

if globPushingSound != -1 audio_stop_sound(globPushingSound)
if walkingSound != -1 audio_stop_sound(walkingSound)

if dead {
	global.playerCandyRemaining = candyRemaining
	part_particles_create(global.particleSystem, x, y, global.partPlayerDeath, 50)
	
	with(objGame) event_user(0)
} else {
	global.playerLastX = -1
	global.playerLastY = -1
}