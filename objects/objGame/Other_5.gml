if room == rmInit exit

layer_destroy(foregroundLayer)

if sprTileLayer != -1 layer_destroy(sprTileLayer)
sprTileLayer = -1