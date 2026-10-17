if(!aberto) exit;

var _gw	= display_get_gui_width();
var _x	= _gw / 2 - 230;
var _y	= 100;
var _h	= 110 + array_length(loja) * 36;

draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_alpha(.9);
draw_set_color(c_black);
draw_rectangle(_x, _y, _x + 460, _y + _h, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(_x, _y, _x + 460, _y + _h, true);

draw_text(_x + 20, _y + 16, "Velho: Suas almas valem muito...");
draw_set_color(c_aqua);
draw_text(_x + 20, _y + 44, "Almas: " + string(global.almas));

for(var i = 0; i < array_length(loja); i++){
	var _it = loja[i];
	draw_set_color((i == sel) ? c_yellow : c_white);
	draw_text(_x + 20, _y + 84 + i * 36, ((i == sel) ? "> " : "   ") + _it.nome + "  (" + string(_it.custo) + " almas)");
}

draw_set_color(c_gray);
draw_text(_x + 20, _y + _h - 28, "Cima/Baixo: escolher | ENTER: comprar | E/ESC: sair");

draw_set_color(c_white);
