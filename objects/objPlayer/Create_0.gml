
instance_create_layer(0, 0, "Instances", objCamera)

#region Movement variables
inputX = 0
pressedJump = false
jumpLeeway = 15 //number of frames to say jump button is pressed (for bouncing)
holdJump = false
holdSpit = false

moveSpeed = 12
accelSpeed = 2
deaccelSpeed = 2
speedMod = 1 //automatically reset after every step

jumpVelocity = -15
coyoteTime = 10
justJumped = false

onGround = false
xSpeed = 0
kxSpeed = 0 //kinetic xspeed
ySpeed = 0
#endregion

#region Swing variables
grappleX = 0
grappleY = 0
swingAccelSpeed = 0.2
swingLength = 0
swingAngle = 0
swingVelocity = 0
swingVelocityMod = 8
swingVelocityInputMod = 0.05

#endregion

enum playerState {
	NORMAL,
	SWING
}
state = playerState.NORMAL

faceX = 1 //direction you're facing
squishX = 1 //squish factor
squishY = 1

spitCharge = 0
spitChargeSpeed = 0.01
spitChargeNecessaryToShoot = 0.35

projectile_guides = ds_list_create()