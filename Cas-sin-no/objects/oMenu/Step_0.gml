var _cima	= keyboard_check_pressed(vk_up)		|| keyboard_check_pressed(ord("W"));
var _baixo	= keyboard_check_pressed(vk_down)	|| keyboard_check_pressed(ord("S"));
var _esq	= keyboard_check_pressed(vk_left)	|| keyboard_check_pressed(ord("A"));
var _dir	= keyboard_check_pressed(vk_right)	|| keyboard_check_pressed(ord("D"));
var _ok		= keyboard_check_pressed(vk_enter)	|| keyboard_check_pressed(vk_space);
var _voltar	= keyboard_check_pressed(vk_escape);

if(aviso > 0) aviso--;

if(estado == 0){
	//=== Menu principal ===
	sel = (sel + _baixo - _cima + 3) mod 3;
	
	if(_ok){
		switch(sel){
			case 0:	//Novo Jogo
				audio_play_sound(mPlay, 1, false);
				audio_stop_sound(mMusic_menu);
				game_reset();
				room_goto(Room1);	//Troque pra rVelho se quiser começar no velho
			break;
			
			case 1:	//Carregar
				if(tem_save){
					audio_play_sound(mPlay, 1, false);
					audio_stop_sound(mMusic_menu);
					game_carregar();
				}else{
					aviso = 90;
					audio_play_sound(mVoltar, 1, false);
				}
			break;
			
			case 2:	//Opções
				estado	= 1;
				sel		= 0;
			break;
		}
	}
}else{
	//=== Opções (0 = volume, 1 = voltar) ===
	sel = (sel + _baixo - _cima + 2) mod 2;
	
	if(sel == 0){
		global.volume = clamp(round((global.volume + (_dir - _esq) * .1) * 10) / 10, 0, 1);
		audio_master_gain(global.volume);
	}
	
	if((sel == 1 && _ok) || _voltar){
		estado	= 0;
		sel		= 2;
		audio_play_sound(mVoltar, 1, false);
	}
}
