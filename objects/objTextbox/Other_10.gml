///@desc Parse current dialogue

var str = texts[current]
nChars = 0
nCharsTotal = string_length(str)
ds_list_clear(charList)
ds_list_clear(wordLengths)
ds_list_clear(wordPositions)
ds_list_clear(modifiers)

var lastWordPos = 0
var i, prevChar = "", indexMod = 0, lastValidPos = 0
for (i = 1; i < nCharsTotal + 1; i++) {
	var char = string_char_at(str, i)
	switch (char) {
		case " ": {
			var len = i - lastWordPos
			ds_list_add(wordLengths, len)
			ds_list_add(wordPositions, i - 1 - indexMod)
		
			lastWordPos = i
		} break
		case "[": {
			indexMod++
			lastWordPos++
				
			var cstr = ""
			for (var j = i + 1; j < nCharsTotal + 1; j++) {
				indexMod++
				lastWordPos++
				var cc = string_char_at(str, j)
				if cc == "]" break
				cstr += cc
			}
				
			split = string_split(cstr, "=", true, 1)
			var commandS = array_length(split) > 1 ? split[0] : cstr
			var commandD = array_length(split) > 1 ? split[1] : ""
			var isCancel = false
			if string_char_at(commandS, 1) == "/" {
				isCancel = true
				commandS = string_delete(commandS, 1, 1)
			}
			var cmd = -1
			var _data = -1
				
			switch(commandS) {
				case "c":
				case "color": {
					cmd = textModifier.color
					switch(commandD) {
						case "red": _data = c_red break
						case "white": _data = c_white break
						case "cyan": _data = make_color_rgb(89, 255, 238) break
						case "lime green": _data = make_color_rgb(99, 255, 99) break
						case "black": _data = c_black break
						case "blue": _data = c_blue break 
						case "purple": _data = c_purple break
						case "orange": _data = c_orange break
					}
					if isCancel _data = -1
				} break
				case "float": {
					cmd = textModifier.float
				} break
				case "finishLevel": {
					cmd = textModifier.finishLevel
					if commandD != "" && asset_get_type(commandD) == asset_room {
						_data = asset_get_index(commandD)	
					}
				} break
			}
				
			if cmd > -1 {
				ds_list_add(modifiers, {
					index: lastValidPos - 1,
					command: cmd,
					data: _data,
					cancel: isCancel,
					text: cstr
				})
			}
			i = j
			continue
		} break
	}
	
	ds_list_add(charList, char)
	lastValidPos = i - indexMod
	prevChar = char
}

nModifiers = ds_list_size(modifiers)
nCharsTotal = ds_list_size(charList)

var len = i - lastWordPos
ds_list_add(wordLengths, len)
ds_list_add(wordPositions, i)