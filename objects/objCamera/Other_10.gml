///@desc Start resize

var pm = matrix_build_projection_ortho(global.viewWidth, global.viewHeight, 1, 10000)
camera_set_proj_mat(camera, pm)

boundLeft = global.viewWidth / 2
boundRight = room_width - global.viewWidth / 2
boundTop = global.viewHeight / 2
boundBottom = room_height - global.viewHeight / 2

alarm[0] = 10