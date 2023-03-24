
#macro NUMBER_OF_PIXELS_CONSIDERED_SLOPE 5

function place_move_x(deltaX, onGround=false){
	if deltaX == 0 exit
	
	var n = 1, basespd = deltaX, ts = sign(deltaX), ta = abs(deltaX)
	if ta > 32{ //Allow stupidly high speeds without warping through solids
	    basespd = ts * 32
	    n = ta mod 32
	}
	repeat(n){
	    if !place_meeting(x + basespd, y, parSolid)
	        x += basespd
	    else {
			repeat(abs(basespd)) {
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
	}
	
	if onGround { //Keep player on ground
		yDist = ta * 2
		if place_meeting(x, y + yDist, parSolid) || place_meeting_platform(x, yDist) {
			place_move_y(ta * 2)
		}
	}
}


function place_move_y(deltaY) {
	if deltaY == 0 exit

	var n = 1, basespd = deltaY, ts = sign(deltaY), ta = abs(deltaY)
	if ta > 32{ //Allow stupidly high speeds without warping through solids
	    basespd = ts * 32
	    n = ta mod 32
	}

	repeat(n){
	    if !place_meeting(x, y + basespd, parSolid) && 
		(ts <= 0 || !place_meeting_platform(0, basespd)) {
	        y += basespd
		}
		else {
	        repeat(abs(basespd)) {
	            if !place_meeting(x, y + ts, parSolid) &&
				(ts <= 0 || !place_meeting_platform(0, 1)) {
	                y += ts
				}
				else break
	        }
	    }
	}

}


function place_meeting_platform(deltaX, deltaY) {
	return collision_rectangle(bbox_left + deltaX, bbox_bottom, bbox_right + deltaX, bbox_bottom+deltaY, parPlatform, 0, 0)
}
