event_inherited();

//Personalizando as variáveis
vel_jump	= 9;
atk_cd		= 0;
atk_vis		= 0;	//Frames mostrando o arco do soco
combo		= 0;	//O 3º soco seguido bate mais forte
combo_t		= 0;
dash_t		= 0;	//Frames de dash restantes
dash_cd		= 0;	//Recarga do dash
bloq		= 0;	//Frames sem agir logo depois de fechar um menu (evita soco no clique)

inputs	= {
		left	: ord("A"),
		right	: ord("D"),
		pulo	: vk_space,
		golpe	: ord("F")
}

//Se começar o jogo direto numa sala (debug), cria o controlador do jogo
if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

//Alcance do soco em pixels (melhora comprando no velho)
alcance_soco = function(){
	return 72 + global.alcance_bonus * 20;
}

//Chamado pelos inimigos e balas
levar_dano = function(_dano){
	if(invul > 0 || global.pausado) return;
	
	global.hp	-= _dano;
	invul		= 60;
	velv		= -4;	//Pulinho de susto
	audio_play_sound(mSoco, 1, false);
	
	if(global.hp <= 0) game_morrer();
}
