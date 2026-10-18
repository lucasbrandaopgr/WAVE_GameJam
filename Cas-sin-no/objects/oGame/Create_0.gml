//Só pode existir um (o objeto é Persistent: sobrevive às trocas de sala,
//por isso moedas/almas/vida não zeram mais quando você passa pela porta)
if(instance_number(oGame) > 1){
	instance_destroy();
	exit;
}

game_reset();

global.debug	= true;		//TROQUE PARA false ANTES DE ENVIAR O JOGO!
global.volume	= 1;
audio_master_gain(global.volume);

mostrar_debug	= true;

//GUI sempre em 1280x720: os menus e minigames usam essas coordenadas
display_set_gui_size(1280, 720);

//Menu de pause
pausa		= false;
pausa_sel	= 0;
pausa_itens	= ["Continuar", "Salvar jogo", "Volume", "Menu principal"];
aviso_salvo	= 0;
mx_ant		= -1;
my_ant		= -1;

pausa_rect = function(_i){
	var _gw = display_get_gui_width();
	return {x: _gw / 2 - 220, y: 270 + _i * 62, w: 440, h: 50};
}

pausa_fechar = function(){
	pausa			= false;
	global.pausado	= false;
}
