
function Menu() constructor {
	buttons = ds_list_create()
	length = 0
	current = -1
	keyboardActive = false
	gamepadAxisTimer = 0
	
	static cleanup = function() {
        ds_list_destroy(buttons)
    }
	
	static reset = function() {
		current = -1
		keyboardActive = false
		gamepadAxisTimer = 0
	}
	
	static addButton = function(btn) {
		ds_list_add(buttons, btn)
		length++
	}
	
	static setButtonDimensions = function(ind, x1, y1, x2, y2) {
		var btn = buttons[| ind]
		btn.setDimensions(x1, y1, x2, y2)
	}
	
	static step = function(mouseX, mouseY) {
		current -= keyboard_check_pressed(ord("W")) - keyboard_check_pressed(ord("S"))
		if abs(gamepad_axis_value(0, gp_axislv)) > 0.25 && gamepadAxisTimer == 0 {
			current += sign(gamepad_axis_value(0, gp_axislv))
			gamepadAxisTimer = 15
		}
		if gamepadAxisTimer > 0 gamepadAxisTimer--
		
		if !keyboardActive && current != -1 keyboardActive = true
		
		if keyboardActive {
			if current < 0 current = length - 1
			if current >= length current = 0
		}
		
		for (var i = 0;	i < length; i++) {
			var btn = buttons[| i]
			var mouseIn = point_in_rectangle(mouseX, mouseY, btn.x1, btn.y1, btn.x2, btn.y2)
			var active = current == i || mouseIn
			if mouseIn {
				keyboardActive = false
				current = -1
			}
			
			btn.step(active)
		}
	}
	
	static draw = function() {
		draw_set_font(fntDefault)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_set_color(c_white)
		for (var i = 0;	i < length; i++) {
			buttons[| i].draw()	
		}
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
}

function Button(label, callback, X1=0, Y1=0, X2=0, Y2=0) constructor {
	text = label
	func = callback
	x1 = X1
	y1 = Y1
	x2 = X2
	y2 = Y2
	isActive = false
	
	function setDimensions(X1, Y1, X2, Y2) {
		x1 = X1
		y1 = Y1
		x2 = X2
		y2 = Y2
	}
	
	function step(active) {
		isActive = active
	}
	
	function draw() {
		var press = keyboard_check_released(vk_enter) ||keyboard_check_released(vk_space) || mouse_check_button_released(mb_left) || gamepad_button_check_pressed(0, gp_face1)
		if isActive && press
			func()

		draw_sprite_stretched(sprMenuButton, isActive, x1, y1, x2 - x1, y2 - y1)
		draw_text(x1 + (x2 - x1) / 2, y1 + (y2 - y1) / 2, text)
	}
}
