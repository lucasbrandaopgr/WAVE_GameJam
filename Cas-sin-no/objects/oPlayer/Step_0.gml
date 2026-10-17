//Parado (roleta girando ou loja do velho aberta)
if(global.pausado){
	velh = 0;
	exit;
}

//Controlando o player
var _chao = place_meeting(x, y + 1, oChao);

var _left, _right, _jump;
_left	= keyboard_check(inputs.left);
_right	= keyboard_check(inputs.right);
_jump	= keyboard_check_pressed(inputs.pulo);

//global.buff_vel vem da roleta (1 = normal)
velh	= (_right - _left) * vel * global.buff_vel;

//Olhando pra onde anda
if(velh != 0) dir = sign(velh);

//Vamo pular
if(_chao){
	if(_jump){
		velv = -vel_jump;
		audio_play_sound(mPulo, 1, false);
	}
}else{
	//Aplico a gravidade
	velv += grav;
}

//Invencibilidade: pisca enquanto dura
if(invul > 0) invul--;
image_alpha = (invul > 0 && (invul div 4) mod 2 == 0) ? .4 : 1;

//Golpe
if(atk_cd > 0) atk_cd--;

if(keyboard_check_pressed(inputs.golpe) && atk_cd <= 0){
	atk_cd = 20;
	audio_play_sound(mPorrete, 1, false);
	
	//Procura um inimigo na frente (28 pixels de alcance)
	var _alvo = instance_place(x + dir * 28, y, oEnemy);
	if(_alvo){
		var _dano = (1 + global.dmg_bonus) * global.buff_dmg;
		_alvo.levar_dano(_dano, x);
	}
}

//Caiu do mapa
if(y > room_height + 100) game_morrer();
