
camera = camera_create()
var vm = matrix_build_lookat(0, 0, -1000, 0, 0, 0, 0, 1, 0)
var pm = matrix_build_projection_ortho(global.viewWidth, global.viewHeight, 1, 10000)

camera_set_view_mat(camera, vm)
camera_set_proj_mat(camera, pm)

gamePaused = false

followPlayer = false
if instance_exists(objPlayer) {
	followPlayer = true
	x = objPlayer.x
	y = objPlayer.y
}
xto = x
yto = y
boundLeft = 0
boundRight = 0
boundTop = 0
boundBottom = 0

view_camera[0] = camera
view_enabled = true
view_visible[0] = true

controlResize()