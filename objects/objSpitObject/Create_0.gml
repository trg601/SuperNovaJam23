event_inherited()

globBounceForce = 30

angle = 0
leftY = 0
rightY = 0
leftX = 0
rightX = 0

addX = 0
addY = 0

event_user(0)

if angle < 90 || angle > 270 {
	while(place_meeting(x, y, parSolid)) {
	y -= 5
	}
	if place_meeting(x, y, parPlatform) y -= 15
}