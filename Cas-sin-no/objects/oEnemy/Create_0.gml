event_inherited();

//Personalizando as variáveis
vel		= 1;
dir		= 1;
hp		= 3;
stun	= 0;

levar_dano = function(_dano, _x_origem){
	hp		-= _dano;
	velh	= sign(x - _x_origem) * 4;	//Empurrão
	stun	= 15;
	
	if(hp <= 0){
		global.almas++;
		instance_destroy();
	}
}