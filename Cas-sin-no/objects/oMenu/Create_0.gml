if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

estado		= 0;	//0 = menu principal, 1 = opções
sel			= 0;
principal	= ["Novo Jogo", "Carregar", "Opções", "Sair"];
tem_save	= game_tem_save();
aviso		= 0;
mx_ant		= -1;
my_ant		= -1;

if(!audio_is_playing(mMusic_menu)) audio_play_sound(mMusic_menu, 0, true);

//Retângulo (clicável) de cada item
rect_item = function(_i){
	var _gw = display_get_gui_width();
	var _gh = display_get_gui_height();
	return {x: _gw / 2 - 220, y: _gh * .46 + _i * 62, w: 440, h: 50};
}

n_itens = function(){
	return (estado == 0) ? array_length(principal) : 2;
}
