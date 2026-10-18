//Fica vermelho quando leva dano
image_blend = (stun > 0) ? c_red : cor_base;

//Congelado (roleta / loja / pause)
if(global.pausado){
	velh = 0;
	exit;
}

//Checando se o inimigo tá no chão
var _chao = place_meeting(x, y + 1, oChao);

if(_chao){
	if(stun > 0){
		//Levou dano: desliza pelo empurrão
		stun--;
		velh *= .85;
	}else if(parado){
		velh = 0;
	}else{
		//Se eu estou no chão eu ando
		patrulhar();
	}
}else{
	//Se não estou no chão
	velv += grav;
}

//Encostou no player? Dá dano
var _p = instance_place(x, y, oPlayer);
if(_p) _p.levar_dano(dano);
