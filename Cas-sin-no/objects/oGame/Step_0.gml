//Mantém o GUI em 1280x720 (alguns sistemas resetam ao trocar de sala)
display_set_gui_size(1280, 720);

//Contador dos buffs/debuffs da roleta
if(global.buff_timer > 0 && !global.pausado){
	global.buff_timer--;
	if(global.buff_timer <= 0){
		global.buff_vel		= 1;
		global.buff_dmg		= 1;
		global.buff_nome	= "";
	}
}

//Música do gameplay
if(sala_de_jogo()){
	if(!audio_is_playing(mGameplay)) audio_play_sound(mGameplay, 0, true);
}else{
	audio_stop_sound(mGameplay);
}

//=== MENU DE PAUSE (ESC) ===
var _lock = (global.esc_lock > 0);
if(global.esc_lock > 0) global.esc_lock--;

if(!sala_de_jogo()){
	pausa = false;
}else if(!pausa){
	//Só abre se nenhuma outra janela (loja, cassino, roleta) estiver aberta
	if(keyboard_check_pressed(vk_escape) && !global.pausado && !_lock){
		pausa			= true;
		global.pausado	= true;
		pausa_sel		= 0;
		aviso_salvo		= 0;
		audio_play_sound(mVoltar, 1, false);
	}
}else{
	var _cima	= keyboard_check_pressed(vk_up)		|| keyboard_check_pressed(ord("W"));
	var _baixo	= keyboard_check_pressed(vk_down)	|| keyboard_check_pressed(ord("S"));
	var _esq	= keyboard_check_pressed(vk_left)	|| keyboard_check_pressed(ord("A"));
	var _dir	= keyboard_check_pressed(vk_right)	|| keyboard_check_pressed(ord("D"));
	var _ok		= keyboard_check_pressed(vk_enter)	|| keyboard_check_pressed(vk_space);
	var _clique	= mouse_check_button_pressed(mb_left);
	var _mexeu	= (ui_mx() != mx_ant || ui_my() != my_ant);
	mx_ant = ui_mx();
	my_ant = ui_my();
	
	if(aviso_salvo > 0) aviso_salvo--;
	
	pausa_sel = (pausa_sel + _baixo - _cima + 4) mod 4;
	
	//Mouse: passar por cima seleciona, clicar confirma
	var _vol_mouse = 0;
	for(var i = 0; i < 4; i++){
		var _r = pausa_rect(i);
		if(ui_sobre(_r.x, _r.y, _r.w, _r.h)){
			if(_mexeu || _clique) pausa_sel = i;
			if(_clique){
				_ok = true;
				//No item de volume, clicar nas pontas muda o volume
				if(i == 2){
					_ok = false;
					if(ui_mx() < _r.x + 70) _vol_mouse = -1;
					else if(ui_mx() > _r.x + _r.w - 70) _vol_mouse = 1;
				}
			}
		}
	}
	
	if(pausa_sel == 2){
		var _mud = (_dir - _esq) + _vol_mouse;
		if(_mud != 0){
			global.volume = clamp(round((global.volume + _mud * .1) * 10) / 10, 0, 1);
			audio_master_gain(global.volume);
		}
	}
	
	if(_ok){
		switch(pausa_sel){
			case 0:
				pausa_fechar();
			break;
			case 1:
				game_salvar(room);
				aviso_salvo = 120;
				audio_play_sound(mPower_up, 1, false);
			break;
			case 3:
				pausa_fechar();
				audio_stop_sound(mGameplay);
				room_goto(rMenu);
			break;
		}
	}
	
	if(keyboard_check_pressed(vk_escape)) pausa_fechar();
}

//=== ATALHOS DE DEBUG (teclas numéricas da linha de cima) ===
if(global.debug && !global.pausado){
	if(keyboard_check_pressed(ord("1"))){
		var _ra = room_previous(room);
		if(_ra != -1) room_goto(_ra);
	}
	if(keyboard_check_pressed(ord("2"))){
		var _rb = room_next(room);
		if(_rb != -1) room_goto(_rb);
	}
	if(keyboard_check_pressed(ord("3"))) room_restart();
	if(keyboard_check_pressed(ord("4"))) global.moedas += 10;
	if(keyboard_check_pressed(ord("5"))) global.almas += 3;
	if(keyboard_check_pressed(ord("6"))) global.hp = global.hp_max;
	if(keyboard_check_pressed(ord("7"))) room_goto(rMenu);
	if(keyboard_check_pressed(ord("8")) && sala_de_jogo()) game_morrer();
	if(keyboard_check_pressed(ord("9"))){
		game_reset();
		room_restart();
	}
	if(keyboard_check_pressed(ord("0"))) mostrar_debug = !mostrar_debug;
}
