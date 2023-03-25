

function reflect_angle(incidenceAngle, surfaceAngle) {
  var a = surfaceAngle * 2 - incidenceAngle
  return a >= 360 ? a - 360 : (a < 0 ? a + 360 : a)
}