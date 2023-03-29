if !loaded || alarm[1] != -1 exit

if nChars < nCharsTotal {
	if keyboard_check(vk_enter) || keyboard_check(vk_space) ||
	gamepad_button_check(0, gp_face1) || gamepad_button_check(0, gp_face3) || mouse_check_button(mb_left)
		nChars += typewriterSpeed * 4
	else nChars += typewriterSpeed
	
	if nChars > nCharsTotal
		nChars = nCharsTotal
}
else if keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) ||
gamepad_button_check_pressed(0, gp_face1) || gamepad_button_check_pressed(0, gp_face3) || mouse_check_button_pressed(mb_left) {
	alarm[1] = 15
	if current >= array_length(texts) - 1 instance_destroy()
	else {
		current++
		event_user(0)
	}
}