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