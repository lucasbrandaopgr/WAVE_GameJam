velh		= 0;
velv		= 0;
vel			= 5;
grav		= .3;
vel_jump	= 9;

inputs	= {
		left	: ord("A"),
		right	: ord("D"),
		pulo	: vk_space,
		golpe	: ord("F")
}
dir		= 1;
invul	= 0;	//Frames de invencibilidade depois de levar dano
atk_cd	= 0;	//Tempo de recarga do golpe

//Variáveis globais (só criam na primeira vez, pra não resetar ao trocar de sala)
if(!variable_global_exists("hp_max")){
	global.hp_max		= 10;
	global.hp			= 10;
	global.moedas		= 0;
	global.almas		= 0;
	global.dmg_bonus	= 0;
}

levar_dano = function(_dano){
	if(invul > 0) exit;
	
	global.hp	-= _dano;
	invul		= 60;
	velv		= -4;	//Pulinho de susto
	
	//Morreu: o imortal volta na sala do velho
	if(global.hp <= 0){
		global.hp = global.hp_max;
		room_goto(rVelho);
	}
}