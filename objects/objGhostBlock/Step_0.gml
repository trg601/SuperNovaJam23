
sinCount+=0.05
sinCountX+=0.03

posX = sin(sinCountX) * 2
posY = sin(sinCount) * 2

if place_meeting(x, y - 1, objPlayer) {
	objPlayer.addX = posX
	objPlayer.addY = posY
}

if place_meeting(x, y - 1, objSpitObject) {
	var ins = instance_place(x, y - 1, objSpitObject) 
	ins.addX = posX
	ins.addY = posY
}