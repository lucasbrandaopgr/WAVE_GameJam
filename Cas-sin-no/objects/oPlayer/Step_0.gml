//Parado (roleta, loja, cassino ou pause)
if(global.pausado){
	velh	= 0;
	bloq	= 8;
	sprite_index = sPlayer;
	exit;
}

if(bloq > 0) bloq--;
if(atk_vis > 0) atk_vis--;

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

//Dash (SHIFT ou botão direito): arranca pra frente e fica invulnerável por um instante
if(dash_cd > 0) dash_cd--;

var _dash = keyboard_check_pressed(vk_shift) || mouse_check_button_pressed(mb_right);
if(_dash && dash_cd <= 0 && dash_t <= 0 && bloq <= 0){
	dash_t	= 10;
	dash_cd	= max(20, 60 - global.dash_bonus * 10);
	invul	= max(invul, 16);
	audio_play_sound(mPulo, 1, false);
}

if(dash_t > 0){
	dash_t--;
	velh = dir * 7;
	velv = 0;
}

//Troca de sprite: parado x correndo (depois do dash, pra ele contar também)
sprite_index = (velh != 0) ? sPlayer_run : sPlayer;
image_xscale = dir;

//Invencibilidade: pisca enquanto dura
if(invul > 0) invul--;
image_alpha = (invul > 0 && (invul div 4) mod 2 == 0) ? .4 : 1;

//Golpe (F ou clique esquerdo)
if(atk_cd > 0) atk_cd--;
if(combo_t > 0){
	combo_t--;
	if(combo_t <= 0) combo = 0;
}

var _golpe = keyboard_check_pressed(inputs.golpe) || mouse_check_button_pressed(mb_left);

if(_golpe && atk_cd <= 0 && bloq <= 0){
	atk_cd		= 18;
	atk_vis		= 8;
	combo++;
	combo_t		= 40;
	audio_play_sound(mPorrete, 1, false);
	
	//Área do soco: um retângulo na frente do player (bem mais generoso que antes)
	var _alc	= alcance_soco();
	var _x1		= x - dir * 8;
	var _x2		= x + dir * _alc;
	var _y1		= y - 46;
	var _y2		= y + 6;
	
	var _mult	= (combo >= 3) ? 1.5 : 1;	//3º soco seguido = +50%
	var _dano	= (1 + global.dmg_bonus) * global.buff_dmg * _mult;
	
	var _lista	= ds_list_create();
	var _n		= collision_rectangle_list(_x1, _y1, _x2, _y2, oEnemy, false, true, _lista, false);
	for(var i = 0; i < _n; i++){
		var _alvo = _lista[| i];
		if(instance_exists(_alvo)) _alvo.levar_dano(_dano, x);
	}
	ds_list_clear(_lista);
	
	//O soco também rebate/destrói balas
	var _nb = collision_rectangle_list(_x1, _y1, _x2, _y2, oBala, false, true, _lista, false);
	for(var i = 0; i < _nb; i++){
		if(instance_exists(_lista[| i])) instance_destroy(_lista[| i]);
	}
	ds_list_destroy(_lista);
	
	if(combo >= 3) combo = 0;
}

//Caiu do mapa
if(y > room_height + 100) game_morrer();
