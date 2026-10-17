if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

estado		= 0;	//0 = menu principal, 1 = opções
sel			= 0;
principal	= ["Novo Jogo", "Carregar", "Opções"];
tem_save	= game_tem_save();
aviso		= 0;

if(!audio_is_playing(mMusic_menu)) audio_play_sound(mMusic_menu, 0, true);
