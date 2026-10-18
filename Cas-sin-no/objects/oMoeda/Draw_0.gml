//Pisca nos últimos 3 segundos
if(vida < 180 && (vida div 6) mod 2 == 0) exit;

draw_set_color(c_orange);
draw_circle(x, y, 5, false);
draw_set_color(c_yellow);
draw_circle(x, y, 4, false);
draw_set_color(c_white);
draw_circle(x - 1, y - 1, 1, false);
draw_set_color(c_white);
