if(!aberto) exit;

var _x	= painel_x();
var _y	= painel_y();
var _h	= 84 + array_length(loja) * 42 + 10 + 40 + 40;

draw_set_halign(fa_left);
draw_set_valign(fa_top);

ui_painel(_x, _y, 520, _h, .92);

draw_set_color(c_white);
draw_text(_x + 20, _y + 16, "Velho: Suas almas valem muito...");
draw_set_color(c_aqua);
draw_text(_x + 20, _y + 44, "Almas: " + string(global.almas)
	+ "     HP máx: " + string(global.hp_max) + "     Dano: " + string(1 + global.dmg_bonus));

for(var i = 0; i < array_length(loja); i++){
	var _it		= loja[i];
	var _r		= linha_rect(i);
	var _feito	= (_it.limite > 0 && comprados(_it.tipo) >= _it.limite);
	var _pode	= (global.almas >= _it.custo) && !_feito;
	var _txt	= _it.nome + "  (" + string(_it.custo) + " almas)";
	if(_it.limite > 0) _txt = _it.nome + "  (" + string(_it.custo) + " almas)  " + string(comprados(_it.tipo)) + "/" + string(_it.limite);
	if(_feito) _txt = _it.nome + "  (MÁXIMO)";
	
	ui_desenhar_botao(_r.x, _r.y, _r.w, _r.h, _txt, _pode, (i == sel), 1);
}

var _s = sair_rect();
ui_desenhar_botao(_s.x, _s.y, _s.w, _s.h, "Sair", true, ui_sobre(_s.x, _s.y, _s.w, _s.h), 1.1);

if(aviso > 0){
	draw_set_halign(fa_center);
	draw_set_color(c_red);
	draw_text(_x + 260, _y + _h - 52, "Almas insuficientes (ou já no máximo)!");
}

draw_set_halign(fa_left);
draw_set_color(c_gray);
draw_text(_x + 20, _y + _h - 26, "Mouse ou Cima/Baixo + ENTER  |  E/ESC: sair");

draw_set_color(c_white);
