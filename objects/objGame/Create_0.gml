//Makes compiler call the init function when the game is started, creating this object in rmInit
gml_pragma("global", "game_init()")
game_set_speed(60, gamespeed_fps)

//Go to start room (Signified by home icon)
room = global.roomGoto

//Global setup
global.freezeInput = false
global.worldGravity = 1 
global.terminalVelocity = 30
