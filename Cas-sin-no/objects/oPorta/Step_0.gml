if(aviso > 0) aviso--;

if(jogador_perto(x, y - 32, 28, 40) && keyboard_check_pressed(ord("E")) && !global.pausado){
	if(global.moedas >= custo){
		var _proxima	= destino;
		var _novo_andar	= false;
		
		if(_proxima == noone){
			_proxima = room_next(room);
			
			//Fim da fila de salas (depois da Room2 vem a sala da morte): volta pro começo
			//com os inimigos mais fortes (e mais moedas/almas)
			if(_proxima == -1 || _proxima == rMorte){
				_proxima	= Room1;
				_novo_andar	= true;
			}
		}
		
		if(room_exists(_proxima)){
			global.moedas -= custo;
			if(custo > 0) audio_play_sound(mMoeda, 1, false);
			if(_novo_andar) global.nivel++;
			
			game_salvar(_proxima);
			room_goto(_proxima);
		}
	}else{
		aviso = 90;
		audio_play_sound(mVoltar, 1, false);
	}
}
