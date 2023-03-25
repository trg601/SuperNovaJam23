
instance_create_layer(0, 0, "Instances", objCamera)

inputX = 0
pressedJump = false
jumpLeeway = 15 //number of frames to show jump is pressed
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

faceX = 1 //direction you're facing
squishX = 1 //squish factor
squishY = 1

spitCharge = 0
spitChargeSpeed = 0.01
spitChargeNecessaryToShoot = 0.35

projectile_guides = ds_list_create()