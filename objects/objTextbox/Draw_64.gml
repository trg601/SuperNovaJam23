if !loaded exit

var width = global.viewWidth / 1.75, height = global.viewHeight / 3.5, padding = 25
var startX = global.viewWidth / 2 - width / 2, startY = global.viewHeight - 50 - height, 
var defCharHeight = string_height("X")
var xx = startX, yy = startY, wrapPos = xx + width, curWord = -1, nextWordPos = -1

var nextModifierPos = nCharsTotal, curModifier = 0
if nModifiers > 0 nextModifierPos = modifiers[| 0].index

//Draw textbox
draw_sprite_stretched(sprTextbox, 0, startX - padding, startY - padding, width + padding * 2, height + padding * 2)

var defaultColor = c_white, isFloating = false
draw_set_color(c_white)

for (var i = 0; i < nChars; i++) {
	var char = charList[| i]
	while i > nextModifierPos {
		var modifier = modifiers[| curModifier++]
		
		switch(modifier.command) {
			case textModifier.color:
				draw_set_color(modifier.data > -1 ? modifier.data: defaultColor)
				break
			case textModifier.float:
				isFloating = !modifier.cancel
				break
			case textModifier.finishLevel:
				roomTo = room_next(room)
				break
		}
		
		nextModifierPos = curModifier < nModifiers ? modifiers[| curModifier].index : nCharsTotal
	}
	if i > nextWordPos {
		nextWordPos = wordPositions[| ++curWord]
		
		var len = wordLengths[| curWord], w = 0
		for (var b = 0; b < len; b++) w += string_width(charList[| i + b - 1])
		if xx + w > wrapPos {
			xx = startX
			yy += defCharHeight
		}
	}
	var wid = string_width(char)
	var dy = isFloating ? yy + sin(current_time / 500 + i) * 5 : yy
	draw_text(xx, dy, char)
	xx += wid
}

draw_set_color(defaultColor)
