// Inherit the parent event
//Tradução: Herdando evento do pai/Entidade
event_inherited();

//Personalizando as variáveis
vel		= 1;
dir		= 1;
hp		= 3;
stun	= 0;
parado	= false;	//Os filhos usam pra ficar parados (ex: atirando)
alma	= 1;		//Quantas almas solta ao morrer

levar_dano = function(_dano, _x_origem){
	hp		-= _dano;
	velh	= sign(x - _x_origem) * 4;	//Empurrão
	stun	= 15;
	
	if(hp <= 0){
		global.almas += alma;
		instance_destroy();
	}
}

//Anda pra frente; vira se bater na parede ou se acabar o chão
patrulhar = function(){
	var _parede	= place_meeting(x + dir * vel, y, oChao);
	var _px		= (dir > 0) ? bbox_right + 1 : bbox_left - 1;
	var _borda	= !position_meeting(_px, bbox_bottom + 1, oChao);
	
	if(_parede || _borda) dir *= -1;
	
	velh = dir * vel;
}
