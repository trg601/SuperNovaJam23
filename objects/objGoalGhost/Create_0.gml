
sinCount = random(10)
sinCountX = random(10)
posX = 0
posY = 0

y -= 10

if isIntro {
	var ins = instance_create_layer(0, 0, "guiLayer", objTextbox)
	ins.dialogueId = dialogueId
}

var sprites = [sprNpc1, sprNpc2, sprNpc3, sprNpc4]
sprite_index = sprites[sprite]
//image_blend = choose(c_white, c_white, make_color_rgb(223, 255, 181), make_color_rgb(237, 199, 252), make_color_rgb(255, 190, 184))