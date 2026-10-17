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