
global.freezeInput = true

dialogueId = -1
alarm[0] = 1 // load dialogue
loaded = false
texts = ["default"]
current = 0

charList = ds_list_create()
wordLengths = ds_list_create()
wordPositions = ds_list_create()
modifiers = ds_list_create()
nModifiers = 0
nChars = 0
nCharsTotal = 0
typewriterSpeed = 0.4
alarm[1] = 10 //typewriter cooldown
roomTo = -1

enum textModifier {
	color = 0,
	float = 1,
	finishLevel = 2
}