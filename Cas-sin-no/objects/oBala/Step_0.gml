if(global.pausado) exit;

x += dir_tiro * vel_bala;
vida--;

//Acertou o player?
var _p = collision_circle(x, y, 4, oPlayer, false, true);
if(_p){
	_p.levar_dano(1);
	instance_destroy();
	exit;
}

//Bateu na parede ou acabou o tempo
if(collision_circle(x, y, 3, oChao, false, true) || vida <= 0) instance_destroy();
