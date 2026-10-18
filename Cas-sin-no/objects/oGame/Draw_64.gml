var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_font(fMenu);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

//=== HUD ===
if(sala_de_jogo()){
	var _x = 16, _y = 16, _larg = 22;
	var _lh = string_height("A") + 4;	//altura de uma linha de texto na fonte atual
	
	//Barra de HP (10 de vida = 10 blocos)
	draw_set_color(c_black);
	draw_rectangle(_x - 3, _y - 3, _x + global.hp_max * _larg + 3, _y + 19, false);
	draw_set_color(c_dkgray);
	draw_rectangle(_x, _y, _x + global.hp_max * _larg, _y + 16, false);
	draw_set_color(c_red);
	draw_rectangle(_x, _y, _x + max(global.hp, 0) * _larg, _y + 16, false);
	
	var _ty = _y + 24;
	draw_set_color(c_white);
	draw_text(_x, _ty, "HP " + string(global.hp) + "/" + string(global.hp_max)
		+ "     Moedas: " + string(global.moedas)
		+ "     Almas: " + string(global.almas)
		+ "     Andar: " + string(global.nivel + 1));
	
	//Barra do dash (logo abaixo do texto)
	var _dy = _ty + _lh + 4;
	if(instance_exists(oPlayer)){
		var _dmax	= max(20, 60 - global.dash_bonus * 10);
		var _pronto	= 1 - clamp(oPlayer.dash_cd / _dmax, 0, 1);
		draw_set_color(c_black);
		draw_rectangle(_x - 1, _dy, _x + 101, _dy + 10, false);
		draw_set_color((_pronto >= 1) ? c_aqua : c_teal);
		draw_rectangle(_x, _dy + 1, _x + 100 * _pronto, _dy + 9, false);
		draw_set_color(c_white);
		draw_text(_x + 108, _dy - 2, (_pronto >= 1) ? "DASH pronto" : "DASH");
	}
	
	//Efeito ativo da roleta
	if(global.buff_timer > 0){
		draw_set_color(c_yellow);
		draw_text(_x, _dy + max(20, _lh), global.buff_nome + " (" + string(ceil(global.buff_timer / 60)) + "s)");
	}
	
	//Dicas de controle
	draw_set_halign(fa_right);
	draw_set_color(c_gray);
	draw_text(_gw - 16, 16, "A/D mover  |  ESPAÇO pular  |  F ou clique: soco  |  SHIFT ou botão direito: dash  |  E interagir  |  ESC pausa");
	draw_set_halign(fa_left);
}

//=== MENU DE PAUSE ===
if(pausa){
	draw_set_alpha(.75);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gw, _gh, false);
	draw_set_alpha(1);
	
	ui_texto(_gw / 2, 170, "PAUSADO", c_yellow, 4);
	ui_texto(_gw / 2, 225, "HP " + string(global.hp) + "/" + string(global.hp_max) + "   Moedas: " + string(global.moedas)
		+ "   Almas: " + string(global.almas) + "   Andar: " + string(global.nivel + 1), c_ltgray, 1.2);
	
	for(var i = 0; i < 4; i++){
		var _r		= pausa_rect(i);
		var _txt	= pausa_itens[i];
		if(i == 2) _txt = "-    Volume: " + string(round(global.volume * 100)) + "%    +";
		ui_desenhar_botao(_r.x, _r.y, _r.w, _r.h, _txt, true, (i == pausa_sel), 1.4);
	}
	
	if(aviso_salvo > 0) ui_texto(_gw / 2, 270 + 4 * 62 + 10, "Jogo salvo!", c_lime, 1.3);
	
	ui_texto(_gw / 2, _gh - 40, "Mouse ou W/S + ENTER   |   A/D ajusta o volume   |   ESC continua", c_dkgray, 1);
}

//Volta o estado padrão do desenho
draw_set_font(-1);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);