if(aviso > 0) aviso--;

if(jogador_perto(x, y - 32, 28, 40) && keyboard_check_pressed(ord("E")) && !global.pausado){
	if(global.moedas >= custo){
		var _proxima = (destino == noone) ? room_next(room) : destino;
		
		if(_proxima != -1 && room_exists(_proxima)){
			global.moedas -= custo;
			if(custo > 0) audio_play_sound(mMoeda, 1, false);
			
			game_salvar(_proxima);
			room_goto(_proxima);
		}
	}else{
		aviso = 90;
		audio_play_sound(mVoltar, 1, false);
	}
}
