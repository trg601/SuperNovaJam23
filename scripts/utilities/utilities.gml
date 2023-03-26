

function reflect_angle(incidenceAngle, surfaceAngle) {
	var a = surfaceAngle * 2 - incidenceAngle
	return a >= 360 ? a - 360 : (a < 0 ? a + 360 : a)
}

function get_raycast(startX, startY, dir) {
	var n = 1000 / 32, xx = startX, yy = startY
	var ldx = lengthdir_x(32, dir), ldy = lengthdir_y(32, dir)
	repeat(n) {
		if collision_point(xx + ldx, yy + ldy, parSolid, 1, 0) {
			var sx = lengthdir_x(2, dir), sy = lengthdir_y(2, dir)
			repeat(16) {
				xx += sx
				yy += sy
				if collision_point(xx, yy, parSolid, 1, 0) break
			}
			return {x: xx, y: yy}
		}
		xx += ldx
		yy += ldy
	}
	
	return undefined
}
