//tipo: hp, dmg, cura, alcance, dash, ima, troca    |    limite: máximo de compras (0 = sem limite)
loja = [
	{nome: "+2 HP máximo",				custo: 3, tipo: "hp",		limite: 0},
	{nome: "+1 dano",					custo: 4, tipo: "dmg",		limite: 0},
	{nome: "Curar tudo",				custo: 1, tipo: "cura",		limite: 0},
	{nome: "Soco mais longo (+20px)",	custo: 3, tipo: "alcance",	limite: 3},
	{nome: "Dash mais rápido",			custo: 3, tipo: "dash",		limite: 3},
	{nome: "Ímã de moedas (+40px)",		custo: 2, tipo: "ima",		limite: 3},
	{nome: "Trocar por 15 moedas",		custo: 2, tipo: "troca",	limite: 0}
];
sel		= 0;
aberto	= false;
aviso	= 0;
mx_ant	= -1;
my_ant	= -1;

//Quantas vezes o item já foi comprado (para os que têm limite)
comprados = function(_tipo){
	switch(_tipo){
		case "alcance":	return global.alcance_bonus;
		case "dash":	return global.dash_bonus;
		case "ima":		return global.ima_bonus;
	}
	return 0;
}

//Geometria da janela (usada no Step e no Draw)
painel_x = function(){ return display_get_gui_width() / 2 - 260; }
painel_y = function(){ return 90; }
linha_rect = function(_i){
	return {x: painel_x() + 20, y: painel_y() + 84 + _i * 42, w: 480, h: 36};
}
sair_rect = function(){
	return {x: painel_x() + 160, y: painel_y() + 84 + array_length(loja) * 42 + 10, w: 200, h: 40};
}

//Tenta comprar o item _i
comprar = function(_i){
	var _item = loja[_i];
	var _lim_ok = (_item.limite == 0 || comprados(_item.tipo) < _item.limite);
	
	if(global.almas >= _item.custo && _lim_ok){
		global.almas -= _item.custo;
		audio_play_sound(mPower_up, 1, false);
		
		switch(_item.tipo){
			case "hp":
				global.hp_max	+= 2;
				global.hp		= global.hp_max;
			break;
			case "dmg":		global.dmg_bonus		+= 1;	break;
			case "cura":	global.hp				= global.hp_max;	break;
			case "alcance":	global.alcance_bonus	+= 1;	break;
			case "dash":	global.dash_bonus		+= 1;	break;
			case "ima":		global.ima_bonus		+= 1;	break;
			case "troca":	global.moedas			+= 15;	break;
		}
		aviso = 0;
	}else{
		audio_play_sound(mVoltar, 1, false);
		aviso = 60;
	}
}
