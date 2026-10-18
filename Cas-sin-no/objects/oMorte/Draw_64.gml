var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;

draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);

//Fonte da tela de morte (a mesma do menu)
draw_set_font(fMenu);

draw_set_alpha(alpha);

ui_texto(_cx, _gh * .26, "VOCÊ MORREU", c_red, 4);
draw_set_alpha(alpha);
ui_texto(_cx, _gh * .26 + 70, frase, c_gray, 1.5);
draw_set_alpha(alpha);
ui_texto(_cx, _gh * .5, "Mortes: " + string(global.mortes), c_white, 2);
draw_set_alpha(alpha);
ui_texto(_cx, _gh * .5 + 50, "Almas: " + string(global.almas) + "     Moedas: " + string(global.moedas) + "     Andar: " + string(global.nivel + 1), c_white, 1);

if(timer > 60){
	draw_set_alpha(1);
	var _b0 = rect_botao(0);
	var _b1 = rect_botao(1);
	ui_desenhar_botao(_b0.x, _b0.y, _b0.w, _b0.h, "Mais uma vez", true, ui_sobre(_b0.x, _b0.y, _b0.w, _b0.h), 1.2);
	ui_desenhar_botao(_b1.x, _b1.y, _b1.w, _b1.h, "Menu", true, ui_sobre(_b1.x, _b1.y, _b1.w, _b1.h), 1.2);
	ui_texto(_cx, _gh * .78 + 90, "ENTER: mais uma vez   |   ESC: menu", c_dkgray, 1);
}

//Volta o estado padrão do desenho
draw_set_font(-1);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);