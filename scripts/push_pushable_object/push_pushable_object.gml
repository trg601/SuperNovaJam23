function push_pushable_object(ins, xDist, onGround){
	var speedMod = ins.pushableSpeedMod
	var dist = xDist * speedMod
	with(ins) {
		if place_meeting(x + dist, y, parPushable) {
			//Chain reaction
			var ins2 = instance_place(x + dist, y, parPushable);
			if ins2.pushable && ((x < ins2.bbox_left && xDist > 0) || (x > ins2.bbox_right && xDist < 0)) {
				speedMod *= push_pushable_object(ins2, dist, onGround)
			}
		}
		place_move_x(xDist * speedMod, onGround)
		event_user(0)
	}
	return speedMod
}