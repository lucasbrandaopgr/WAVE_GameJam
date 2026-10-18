var _cima	= keyboard_check_pressed(vk_up)		|| keyboard_check_pressed(ord("W"));
var _baixo	= keyboard_check_pressed(vk_down)	|| keyboard_check_pressed(ord("S"));
var _esq	= keyboard_check_pressed(vk_left)	|| keyboard_check_pressed(ord("A"));
var _dir	= keyboard_check_pressed(vk_right)	|| keyboard_check_pressed(ord("D"));
var _ok		= keyboard_check_pressed(vk_enter)	|| keyboard_check_pressed(vk_space);
var _voltar	= keyboard_check_pressed(vk_escape);
var _clique	= mouse_check_button_pressed(mb_left);

if(aviso > 0) aviso--;

var _n		= n_itens();
sel			= (sel + _baixo - _cima + _n) mod _n;

//=== MOUSE: passar por cima seleciona, clicar confirma ===
var _mexeu = (ui_mx() != mx_ant || ui_my() != my_ant);
mx_ant = ui_mx();
my_ant = ui_my();

var _vol_mouse = 0;
for(var i = 0; i < _n; i++){
	var _r = rect_item(i);
	if(ui_sobre(_r.x, _r.y, _r.w, _r.h)){
		if(_mexeu || _clique) sel = i;
		if(_clique){
			_ok = true;
			//Na linha do volume, clicar nas pontas (- / +) ajusta o volume
			if(estado == 1 && i == 0){
				_ok = false;
				if(ui_mx() < _r.x + 80) _vol_mouse = -1;
				else if(ui_mx() > _r.x + _r.w - 80) _vol_mouse = 1;
			}
		}
	}
}

if(estado == 0){
	//=== Menu principal ===
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
			
			case 3:	//Sair
				game_end();
			break;
		}
	}
}else{
	//=== Opções (0 = volume, 1 = voltar) ===
	if(sel == 0){
		var _mud = (_dir - _esq) + _vol_mouse;
		if(_mud != 0){
			global.volume = clamp(round((global.volume + _mud * .1) * 10) / 10, 0, 1);
			audio_master_gain(global.volume);
		}
	}
	
	if((sel == 1 && _ok) || _voltar){
		estado	= 0;
		sel		= 2;
		audio_play_sound(mVoltar, 1, false);
	}
}
