
draw_self()

if !instance_exists(objPlayer) exit

if point_distance(x, y, objPlayer.x, objPlayer.y) < 200 && !instance_exists(objTextbox) {
	var yy = y - 40
	draw_sprite(sprKey, 0, x + 64, yy)
	var text = objPlayer.useGPRecticle ? "X" : "E"
	draw_set_halign(fa_center)
	draw_text(x + 64, yy - 40, text)
	draw_set_halign(fa_left)
	
	if objPlayer.pressedInteract && objPlayer.onGround {
		var ins = instance_create_layer(0, 0, "guiLayer", objTextbox)
		ins.dialogueId = dialogueId  
	}
}