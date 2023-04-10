sinCount+=0.05
sinCountX+=0.03

posX = sin(sinCountX) * 2
posY = sin(sinCount) * 2
x += posX
y += posY
draw_self()
x -= posX
y -= posY

if !instance_exists(objPlayer) || isIntro exit

if point_distance(x, y, objPlayer.x, objPlayer.y) < 200 && !instance_exists(objTextbox) {
	var xx = x + 64 * image_xscale, yy = y - 40
	draw_sprite(sprKey, 0, xx, yy)
	var text = objPlayer.useGPRecticle ? "X" : "E"
	draw_set_halign(fa_center)
	draw_text(xx, yy - 40, text)
	draw_set_halign(fa_left)
	
	if objPlayer.pressedInteract && objPlayer.onGround {
		var ins = instance_create_layer(0, 0, "guiLayer", objTextbox)
		if objPlayer.candyRemaining <= 0
			ins.dialogueId = dialogueId
		else
			ins.dialogueId = 0
	}
}