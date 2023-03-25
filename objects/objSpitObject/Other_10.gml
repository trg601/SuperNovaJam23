///@desc Get placement direction

//(very very messy I know)
var maxDist = 75
leftY = bbox_bottom -  maxDist / 2
rightY = bbox_bottom -  maxDist / 2
leftX = x - 10
rightX = x + 10

repeat(maxDist) {
	leftY += 1
	if collision_point(leftX, leftY, parSolid, true, false) break
}

repeat(maxDist) {
	rightY += 1
	if collision_point(rightX, rightY, parSolid, true, false) break
}

angle = point_direction(leftX, leftY, rightX, rightY)

if angle == 0 {
	leftCollide = collision_point(bbox_left, y, parSolid, true, false)
	rightCollide = collision_point(bbox_right, y, parSolid, true, false)
	
	if leftCollide && !rightCollide angle = 270
	if !leftCollide && rightCollide angle = 90
	if collision_point(x, bbox_top, parSolid, true, false) angle = 180
}

if place_meeting_platform(0, 1) angle = 0

pushable = true
if angle > 90 && angle < 270 pushable = false