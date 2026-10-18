if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

estado		= 0;	//0 = menu principal, 1 = créditos
sel			= 0;
principal	= ["Novo Jogo", "Carregar", "Volume", "Créditos", "Sair"];
tem_save	= game_tem_save();
aviso		= 0;
mx_ant		= -1;
my_ant		= -1;

//Créditos: [função, nome]. Troque pelos seus
creditos = [
	["Programação",		"@rafa_woll,@brandao7335"],
	["Arte",			"@seyy_fl"],
	["Música e sons",	"@sk_wmt10/ Creditos:EasyBrain/COLORALY-50 Menu"]
];

if(!audio_is_playing(mMusic_menu)) audio_play_sound(mMusic_menu, 0, true);

//Retângulo (clicável) de cada item
rect_item = function(_i){
	var _gw = display_get_gui_width();
	var _gh = display_get_gui_height();
	
	//Nos créditos só existe o botão Voltar, mais embaixo
	if(estado == 1) return {x: _gw / 2 - 220, y: _gh * .8, w: 440, h: 50};
	
	return {x: _gw / 2 - 220, y: _gh * .42 + _i * 60, w: 440, h: 50};
}

n_itens = function(){
	return (estado == 0) ? array_length(principal) : 1;
}