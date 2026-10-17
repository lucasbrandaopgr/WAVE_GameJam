//Controlando o player
var _chao = place_meeting(x, y + 1, oChao);

var _left, _right, _jump;
_left	= keyboard_check(inputs.left);
_right	= keyboard_check(inputs.right);
_jump	= keyboard_check_pressed(inputs.pulo);

velh	= (_right - _left) * vel;

//Vamo pular
if(_chao){
	if(_jump){
		velv = -vel_jump;
	}
}else{
	//Aplico a gravidade
	velv += grav;
}
//Direção que o player está olhando
if(velh != 0) dir = sign(velh);

//Piscar quando está invencível
if(invul > 0) invul--;
image_alpha = (invul > 0 && (invul div 4) mod 2) ? .4 : 1;

//Golpe
if(atk_cd > 0) atk_cd--;

if(keyboard_check_pressed(inputs.golpe) && atk_cd <= 0){
	atk_cd = 20;
	audio_play_sound(mSoco, 1, false);
	
	//Procura um inimigo na frente (28 pixels de alcance, ajuste ao seu sprite)
	var _alvo = instance_place(x + dir * 28, y, oEnemy);
	if(_alvo) _alvo.levar_dano(1 + global.dmg_bonus, x);
}