draw_self()

if !instance_exists(objPlayer) exit

if point_distance(x, y, objPlayer.x, objPlayer.y) < 200 && !instance_exists(objTextbox) {
	var yy = bbox_top - 100
	draw_sprite(sprKey, 0, x, yy)
	var text = objPlayer.useGPRecticle ? "X" : "E"
	draw_set_halign(fa_center)
	draw_text(x, yy - 40, text)
	draw_set_halign(fa_left)
	
	if objPlayer.pressedInteract && objPlayer.onGround {
		var ins = instance_create_layer(0, 0, "guiLayer", objTextbox)
		if objPlayer.candyRemaining == 0
			ins.dialogueId = dialogueId
		else
			ins.dialogueId = 0
	}
}