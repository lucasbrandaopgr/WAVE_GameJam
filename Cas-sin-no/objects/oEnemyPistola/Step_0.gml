//Se vê o player no mesmo nível: para, vira pra ele e atira
parado = false;

if(instance_exists(oPlayer) && !global.pausado && stun <= 0){
	var _dist_x			= oPlayer.x - x;
	var _mesmo_nivel	= abs(oPlayer.y - y) < 40;
	
	if(abs(_dist_x) < alcance && _mesmo_nivel){
		parado = true;
		if(_dist_x != 0) dir = sign(_dist_x);
		
		tiro_cd--;
		if(tiro_cd <= 0){
			tiro_cd = 100;
			audio_play_sound(mTiro, 1, false);
			
			var _b = instance_create_depth(x + dir * 18, y - 18, depth - 1, oBala);
			_b.dir_tiro = dir;
			_b.dano		= dano;
		}
	}
}

//Roda o Step do pai (gravidade, patrulha, dano de contato)
event_inherited();
