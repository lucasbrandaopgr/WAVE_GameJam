var _x = 16, _y = 16;

draw_set_color(c_dkgray);
draw_rectangle(_x, _y, _x + global.hp_max * 20, _y + 16, false);
draw_set_color(c_red);
draw_rectangle(_x, _y, _x + global.hp * 20, _y + 16, false);

draw_set_color(c_white);
draw_text(_x, _y + 24, "Moedas: " + string(global.moedas) + "   Almas: " + string(global.almas));