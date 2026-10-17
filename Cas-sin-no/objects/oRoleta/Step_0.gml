if(aviso > 0) aviso--;

switch(estado){
	case 0:	//Parada: espera o player apertar E
		if(jogador_perto(x, y - 24, 30, 40) && keyboard_check_pressed(ord("E")) && !global.pausado){
			if(global.moedas >= custo){
				global.moedas	-= custo;
				global.pausado	= true;
				estado			= 1;
				audio_play_sound(mMoeda, 1, false);
				
				//Sorteia a fatia e calcula onde parar (o ponteiro fica em cima = 90 graus)
				resultado	= irandom(n_fatias - 1);
				var _passo	= 360 / n_fatias;
				var _final	= 90 - (resultado * _passo + _passo / 2);
				var _delta	= (((_final - ang) mod 360) + 360) mod 360;
				ang_alvo	= ang + 360 * 4 + _delta;	//4 voltas + o que falta
			}else{
				aviso = 90;
				audio_play_sound(mVoltar, 1, false);
			}
		}
	break;
	
	case 1:	//Girando: desacelera até parar no alvo
		ang = min(ang + max((ang_alvo - ang) * .04, .5), ang_alvo);
		
		if(ang >= ang_alvo){
			ang		= ang mod 360;
			estado	= 2;
			timer	= 150;
			aplicar(resultado);
		}
	break;
	
	case 2:	//Mostra o resultado e depois libera o jogo
		timer--;
		if(timer <= 0 || keyboard_check_pressed(ord("E"))){
			estado			= 0;
			global.pausado	= false;
		}
	break;
}
