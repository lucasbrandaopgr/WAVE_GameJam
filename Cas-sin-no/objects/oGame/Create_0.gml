//Só pode existir um (o objeto é Persistent)
if(instance_number(oGame) > 1){
	instance_destroy();
	exit;
}

game_reset();

global.debug	= true;		//TROQUE PARA false ANTES DE ENVIAR O JOGO!
global.volume	= 1;
audio_master_gain(global.volume);

mostrar_debug	= true;
