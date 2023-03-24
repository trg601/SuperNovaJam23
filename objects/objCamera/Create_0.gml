
global.defWidth = 1366
global.defHeight = 768
global.winWidth = global.defWidth
global.winHeight = global.defHeight
global.viewScaleMod = 1
global.viewScale = 1
global.viewWidth = global.winWidth
global.viewHeight = global.winHeight


camera = camera_create()
var vm = matrix_build_lookat(0, 0, -1000, 0, 0, 0, 0, 1, 0)
var pm = matrix_build_projection_ortho(global.viewWidth, global.viewHeight, 1, 10000)

camera_set_view_mat(camera, vm)
camera_set_proj_mat(camera, pm)

follow = objPlayer
x = follow.x
y = follow.y
xto = x
yto = y

view_camera[0] = camera
view_enabled = true
view_visible[0] = true

function controlResize() {
	if window_get_fullscreen() {
	    global.winWidth = display_get_width()
	    global.winHeight = display_get_height()
	    global.viewScale = 1 * global.viewScaleMod
	}else{
	    global.winWidth = global.defWidth
	    global.winHeight = global.defHeight
	    global.viewScale = 0.75 * global.viewScaleMod
	}

	view_wport[0] = global.winWidth
	view_hport[0] = global.winHeight
	global.viewWidth = global.winWidth / global.viewScale
	global.viewHeight = global.winHeight / global.viewScale
	surface_resize(application_surface, global.winWidth, global.winHeight)
	window_set_size(global.winWidth, global.winHeight)
	display_set_gui_maximise(global.viewScale, global.viewScale, 0, 0)

	if instance_exists(objCamera) with(objCamera) event_user(0)
}

controlResize()