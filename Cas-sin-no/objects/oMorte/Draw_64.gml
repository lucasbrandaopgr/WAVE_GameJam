var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;

draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(alpha);

draw_set_color(c_red);
draw_text_transformed(_cx, _gh * .28, "VOCÊ MORREU", 4, 4, 0);

draw_set_color(c_gray);
draw_text_transformed(_cx, _gh * .28 + 70, frase, 1.5, 1.5, 0);

draw_set_color(c_white);
draw_text_transformed(_cx, _gh * .55, "Mortes: " + string(global.mortes), 2, 2, 0);
draw_text(_cx, _gh * .55 + 50, "Almas: " + string(global.almas) + "     Moedas: " + string(global.moedas));

if(timer > 60){
	draw_set_color(c_yellow);
	draw_text_transformed(_cx, _gh * .8, "ENTER: mais uma vez", 1.5, 1.5, 0);
	draw_set_color(c_dkgray);
	draw_text(_cx, _gh * .8 + 40, "ESC: menu");
}

//Volta o estado padrão do desenho
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
