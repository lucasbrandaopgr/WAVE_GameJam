event_inherited();

//Personalizando as variáveis
vel_jump	= 9;
atk_cd		= 0;

inputs	= {
		left	: ord("A"),
		right	: ord("D"),
		pulo	: vk_space,
		golpe	: ord("F")
}

//Se começar o jogo direto numa sala (debug), cria o controlador do jogo
if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

//Chamado pelos inimigos e balas
levar_dano = function(_dano){
	if(invul > 0 || global.pausado) return;
	
	global.hp	-= _dano;
	invul		= 60;
	velv		= -4;	//Pulinho de susto
	audio_play_sound(mSoco, 1, false);
	
	if(global.hp <= 0) game_morrer();
}
