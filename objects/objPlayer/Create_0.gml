
#region Input Variables
global.freezeInput = false
inputX = 0
pressedJump = false
jumpLeeway = 15 //number of frames to say jump button is pressed (for bouncing)
holdJump = false
holdSpit = false
pressedGrapple = false
pressedInteract = false
#endregion

#region Movement variables
moveSpeed = 12
accelSpeed = 2
deaccelSpeed = 2
speedMod = 1 //automatically reset after every step

jumpVelocity = -15
maxBounceVelocity = -37
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
swingJumpVelocity = jumpVelocity * 2
#endregion

dead = false

enum playerState {
	NORMAL,
	SWING
}
state = playerState.NORMAL

faceX = 1 //direction you're facing
squishX = 1 //squish factor
squishY = 1
addX = 0
addY = 0

spitCharge = 0
spitChargeSpeed = 0.02
spitChargeNecessaryToShoot = 0.35

//Collectibles
candyCount = instance_number(objCandy)
candyRemaining = candyCount

#region Gamepad
gamepadAxisDeadZone = 0.25
recticleX = 0
recticleY = 0
recticleMinDistance = 100
recticleDistance = 100
recticleActive = false
useGPRecticle = false
mouse_xprev = -1
mouse_yprev = -1
#endregion