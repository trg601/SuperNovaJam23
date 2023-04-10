///@desc Update from checkpoint

if ds_list_size(global.playerCandyList) > 0 {
	for (var i = 0; i < ds_list_size(global.playerCandyList); i++) {
		var pos = global.playerCandyList[| i]
		var ins = instance_position(pos.x, pos.y, objCandy)
		instance_destroy(ins)
	}
	candyRemaining = instance_number(objCandy)
}

if global.playerLastX != -1 {
	x = global.playerLastX
	y = global.playerLastY
	
	if place_meeting(global.playerLastX, global.playerLastY, objCheckpoint) {
		var ins = instance_place(global.playerLastX, global.playerLastY, objCheckpoint)
		ins.image_index = 1
	}
}