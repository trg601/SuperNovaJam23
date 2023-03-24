
if instance_exists(objGame) {
	instance_destroy(objGame)
}

instance_create_layer(0, 0, "Instances", objGame)