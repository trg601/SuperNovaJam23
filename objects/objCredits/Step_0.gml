
if alarm[0] == -1 && (keyboard_check_pressed(vk_anykey) || gamepad_button_check_pressed(0, gp_face1)
 || gamepad_button_check_pressed(0, gp_face2) || gamepad_button_check_pressed(0, gp_face3) || gamepad_button_check_pressed(0, gp_face4)) {
	room = RoomMainMenu
}