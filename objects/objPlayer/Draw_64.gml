

draw_set_font(fntDefault)
if candyCount == 0 exit
draw_set_valign(fa_bottom)
var xx = 40, yy = global.viewHeight - 25
var text = string(candyCount - candyRemaining) + "  /  " + string(candyCount)
draw_text(xx, yy, text)
draw_sprite(sprCandy, 0, string_width(text) + xx + 25, yy - 128)
draw_set_valign(fa_top)
