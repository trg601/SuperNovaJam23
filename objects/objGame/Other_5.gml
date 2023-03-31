if room == rmInit exit

layer_add_instance("Instances", self)
layer_destroy(backgroundLayer)
layer_destroy(foregroundLayer)
layer_destroy(guiLayer)
layer_destroy(behindLayer)

if sprTileLayer != -1 layer_destroy(sprTileLayer)
sprTileLayer = -1