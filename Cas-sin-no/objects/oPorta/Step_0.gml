if(aviso > 0) aviso--;

//Tocando a animação de abrir: espera o último frame e só então troca de sala
if(abrindo){
	if(image_index >= image_number - 1){
		image_speed = 0;
		game_salvar(prox);
		room_goto(prox);
	}
	exit;
}

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
			
			//Chama a animação de abrir (a troca de sala acontece quando ela acabar)
			prox			= _proxima;
			abrindo			= true;
			sprite_index	= sPorta_abrindo;	//Troque pelo nome do seu sprite
			image_index		= 0;
			image_speed		= 1;
		}
	}else{
		aviso = 90;
		audio_play_sound(mVoltar, 1, false);
	}
}