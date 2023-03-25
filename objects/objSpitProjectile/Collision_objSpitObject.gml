
if alarm[0] > 0 exit
alarm[0] = 5

var myangle = point_direction(0, 0, xSpeed, ySpeed)
var angle = reflect_angle(myangle, other.angle)
var spd = point_distance(0, 0, xSpeed, ySpeed)
xSpeed = lengthdir_x(spd, angle)
ySpeed = lengthdir_y(spd, angle)
