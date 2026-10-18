if(global.pausado) exit;

vida--;
if(vida <= 0 || y > room_height + 200){
	instance_destroy();
	exit;
}

if(!instance_exists(oPlayer)) exit;

var _dist = point_distance(x, y, oPlayer.x, oPlayer.y - 16);
var _raio = 70 + global.ima_bonus * 40;

//Ímã: chegando perto, a moeda voa até o player
if(_dist < _raio) atraida = true;

if(atraida){
	var _dir = point_direction(x, y, oPlayer.x, oPlayer.y - 16);
	var _vel = min(9, 3 + (_raio - _dist) * .08 + 2);
	x += lengthdir_x(_vel, _dir);
	y += lengthdir_y(_vel, _dir);
}else{
	//Cai e quica no chão
	velv += grav;
	
	if(position_meeting(x + velh, y, oChao)) velh = -velh * .5;
	x += velh;
	
	if(position_meeting(x, y + velv + 4, oChao)){
		//Pousa em cima do chão (o +4 é o raio da moeda)
		while(!position_meeting(x, y + sign(velv) + 4, oChao)) y += sign(velv);
		velv = (abs(velv) > 1.5) ? -velv * .45 : 0;
		velh *= .7;
	}
	y += velv;
}

//Pegou
if(_dist < 14){
	global.moedas += valor;
	audio_play_sound(mMoeda, 1, false);
	popup(x, y - 10, "+" + string(valor), c_yellow);
	instance_destroy();
}
