
objCamera.followPlayer = false

if dead {
	part_particles_create(global.particleSystem, x, y, global.partPlayerDeath, 50)

	with(objGame) event_user(0)
}