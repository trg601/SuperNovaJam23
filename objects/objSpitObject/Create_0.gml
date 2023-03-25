event_inherited()

globBounceForce = 30


ySpeed = 0
angle = 0
leftY = 0
rightY = 0
leftX = 0
rightX = 0

event_user(0)

if angle < 90 || angle > 270 {
	y -= 15
	if place_meeting(x, y, parPlatform) y -= 15
}