var _chao = place_meeting(x, y + 1, oChao);

if(_chao){
	if(stun > 0){
		//Atordoado: só desliza pelo empurrão
		stun--;
		velh *= .85;
	}else{
		//Vira se bater na parede ou se não tiver chão na frente
		var _parede	= place_meeting(x + dir * vel, y, oChao);
		var _px		= (dir > 0) ? bbox_right + 1 : bbox_left - 1;
		var _borda	= !position_meeting(_px, bbox_bottom + 1, oChao);
		
		if(_parede || _borda) dir *= -1;
		
		velh = dir * vel;
	}
}else{
	velv += grav;
}

//Encostou no player? Dá dano
var _p = instance_place(x, y, oPlayer);
if(_p) _p.levar_dano(1);