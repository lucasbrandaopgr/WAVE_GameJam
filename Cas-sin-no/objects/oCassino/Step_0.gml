if(is_undefined(g)){
	modal_fechou();
	instance_destroy();
	exit;
}

global.pausado = true;
g.passo();

//ESC ou o botão Sair (só habilitado entre rodadas, pra ninguém perder aposta sem querer)
if(keyboard_check_pressed(vk_escape) && g.pode_sair()) g.fechar = true;

if(g.fechar){
	modal_fechou();
	instance_destroy();
}
