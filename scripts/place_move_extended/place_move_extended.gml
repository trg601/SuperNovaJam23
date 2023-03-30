
#macro NUMBER_OF_PIXELS_CONSIDERED_SLOPE 5
#macro MAX_COLLISION_SEGMENT_SPEED 32

function place_move_x(deltaX, onGround=false){
	var collide = false
	if deltaX == 0 return collide
	
	var ts = sign(deltaX), ta = abs(deltaX)
	
	//Allow stupidly high speeds without warping through solids
	if ta > MAX_COLLISION_SEGMENT_SPEED {
	    var n = ta div MAX_COLLISION_SEGMENT_SPEED
		var spd = ts * MAX_COLLISION_SEGMENT_SPEED
		deltaX = deltaX mod MAX_COLLISION_SEGMENT_SPEED
		
		repeat(n)
			if place_move_x(spd, onGround) collide = true
	}
	
	if !place_meeting(x + deltaX, y, parSolid)
	    x += deltaX
	else {
		collide = true
		repeat(abs(deltaX)) {
	        if !place_meeting(x + ts, y, parSolid)
	            x += ts
			else {
	            var i=1
	            repeat(NUMBER_OF_PIXELS_CONSIDERED_SLOPE){
	                if !place_meeting(x + ts, y-i, parSolid) {x += ts y-=i break}
	                i++
	            }
	        }
	    }
	}
	
	if onGround { //Keep object on ground
		yDist = ta * 2
		if place_meeting(x, y + yDist, parSolid) || place_meeting_platform(x, yDist) {
			place_move_y(yDist)
		}
	}
	
	return collide
}


function place_move_y(deltaY) {
	var collide = false
	if deltaY == 0 return collide

	var ts = sign(deltaY), ta = abs(deltaY)
	
	//Allow stupidly high speeds without warping through solids
	if ta > MAX_COLLISION_SEGMENT_SPEED {
	    var n = ta div MAX_COLLISION_SEGMENT_SPEED
		var spd = ts * MAX_COLLISION_SEGMENT_SPEED
		deltaY = deltaY mod MAX_COLLISION_SEGMENT_SPEED
		
		repeat(n)
			if place_move_y(spd) collide = true
	}
	
	if !place_meeting(x, y + deltaY, parSolid) && (ts <= 0 || !place_meeting_platform(0, deltaY)) {
	        y += deltaY
		}
		else {
			collide = true
	        repeat(abs(deltaY)) {
	            if !place_meeting(x, y + ts, parSolid) &&
				(ts <= 0 || !place_meeting_platform(0, 1)) {
	                y += ts
				}
				else break
	        }
	    }
	
	return collide
}


function place_meeting_platform(deltaX, deltaY) {
	return collision_rectangle(bbox_left + deltaX, bbox_bottom, bbox_right + deltaX, bbox_bottom+deltaY, parPlatform, 0, 0)
}
