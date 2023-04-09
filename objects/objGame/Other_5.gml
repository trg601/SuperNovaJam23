if room == rmInit exit

layer_add_instance("Instances", self)
layer_destroy(backgroundLayer)
layer_destroy(foregroundLayer)
layer_destroy(guiLayer)
layer_destroy(behindLayer)

if sprTileLayer != -1 layer_destroy(sprTileLayer)
sprTileLayer = -1

//Reset player data
if room != roomPrevious || global.forceRestart {
	global.playerLastX = -1
	global.playerLastY = -1
	global.playerCandyRemaining = -1
	ds_list_clear(global.playerCandyList)
}