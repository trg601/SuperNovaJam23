///@desc Start resize

var pm = matrix_build_projection_ortho(global.viewWidth, global.viewHeight, 1, 10000)
camera_set_proj_mat(camera, pm)

alarm[0] = 10