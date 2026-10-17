//Checando se o inimigo tá no chão
var _chao = place_meeting(x, y + 1, oChao);

if(_chao){
	//Se eu estou no chão eu ando
	velh = 1;
}else{
	//Se não estou no chão
	velv += grav;
}