var bWidth =  global.viewWidth / 4, bHeight = global.viewHeight / 8, padding = bHeight * 0.25
var xx = global.viewWidth - bWidth / 2 - padding
var yy = global.viewHeight - padding - menu.length * (bHeight + padding)
var leftX = xx - bWidth / 2, rightX = xx + bWidth / 2
	
for (var i = 0; i < menu.length; i++) {
	menu.setButtonDimensions(i, leftX, yy, rightX, yy + bHeight)
	yy += bHeight + padding
}
menu.step(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0))