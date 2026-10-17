var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

//=== HUD ===
if(sala_de_jogo()){
	var _x = 16, _y = 16, _larg = 22;
	
	//Barra de HP (10 de vida = 10 blocos)
	draw_set_color(c_black);
	draw_rectangle(_x - 3, _y - 3, _x + global.hp_max * _larg + 3, _y + 19, false);
	draw_set_color(c_dkgray);
	draw_rectangle(_x, _y, _x + global.hp_max * _larg, _y + 16, false);
	draw_set_color(c_red);
	draw_rectangle(_x, _y, _x + max(global.hp, 0) * _larg, _y + 16, false);
	
	draw_set_color(c_white);
	draw_text(_x, _y + 24, "HP " + string(global.hp) + "/" + string(global.hp_max)
		+ "     Moedas: " + string(global.moedas)
		+ "     Almas: " + string(global.almas));
	
	//Efeito ativo da roleta
	if(global.buff_timer > 0){
		draw_set_color(c_yellow);
		draw_text(_x, _y + 46, global.buff_nome + " (" + string(ceil(global.buff_timer / 60)) + "s)");
	}
}

//=== Overlay de debug ===
if(global.debug && mostrar_debug){
	draw_set_color(c_lime);
	draw_set_valign(fa_bottom);
	draw_text(16, _gh - 16, "[DEBUG] sala: " + room_get_name(room)
		+ "\n1 sala anterior | 2 proxima sala | 3 reiniciar sala | 4 +10 moedas | 5 +3 almas"
		+ "\n6 curar | 7 menu | 8 morrer | 9 reset total | 0 esconde isto");
}

//Volta o estado padrão do desenho
draw_set_valign(fa_top);
draw_set_color(c_white);
