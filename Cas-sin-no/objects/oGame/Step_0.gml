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

//=== ATALHOS DE DEBUG (teclas numéricas da linha de cima) ===
if(global.debug){
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
