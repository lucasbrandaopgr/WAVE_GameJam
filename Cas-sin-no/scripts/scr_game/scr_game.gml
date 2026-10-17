//=====================================================
// scr_game - funções globais do jogo
// Crie um Script chamado scr_game e cole tudo isto
//=====================================================

//Zera tudo (usado em Novo Jogo e no debug)
function game_reset(){
	global.hp_max		= 10;
	global.hp			= 10;
	global.moedas		= 10;
	global.almas		= 0;
	global.dmg_bonus	= 0;
	global.mortes		= 0;
	
	//Efeitos temporários da roleta
	global.buff_vel		= 1;
	global.buff_dmg		= 1;
	global.buff_timer	= 0;
	global.buff_nome	= "";
	
	//Quando true, tudo congela (roleta girando, loja do velho aberta)
	global.pausado		= false;
}

//Sala de jogo = onde aparece o HUD e toca a música de gameplay
function sala_de_jogo(){
	return (room != rMenu && room != rMorte);
}

//O player está perto do ponto (_x, _y)? (usa o centro do player)
function jogador_perto(_x, _y, _dx, _dy){
	if(!instance_exists(oPlayer)) return false;
	return (abs(oPlayer.x - _x) <= _dx) && (abs((oPlayer.y - 16) - _y) <= _dy);
}

//Morreu: o imortal volta, só que agora na sala do velho
function game_morrer(){
	global.mortes++;
	global.hp			= global.hp_max;
	global.buff_vel		= 1;
	global.buff_dmg		= 1;
	global.buff_timer	= 0;
	global.buff_nome	= "";
	global.pausado		= false;
	
	game_salvar(rVelho);
	room_goto(rMorte);
}

//Salva em arquivo ini. _sala = sala onde o jogo vai continuar
function game_salvar(_sala){
	if(is_undefined(_sala)) _sala = room;
	
	ini_open("cassino.ini");
	ini_write_real("save", "existe", 1);
	ini_write_real("save", "hp_max", global.hp_max);
	ini_write_real("save", "moedas", global.moedas);
	ini_write_real("save", "almas", global.almas);
	ini_write_real("save", "dmg_bonus", global.dmg_bonus);
	ini_write_real("save", "mortes", global.mortes);
	ini_write_string("save", "sala", room_get_name(_sala));
	ini_close();
}

function game_tem_save(){
	ini_open("cassino.ini");
	var _r = ini_read_real("save", "existe", 0);
	ini_close();
	return (_r == 1);
}

function game_carregar(){
	game_reset();
	
	ini_open("cassino.ini");
	global.hp_max		= ini_read_real("save", "hp_max", 10);
	global.moedas		= ini_read_real("save", "moedas", 0);
	global.almas		= ini_read_real("save", "almas", 0);
	global.dmg_bonus	= ini_read_real("save", "dmg_bonus", 0);
	global.mortes		= ini_read_real("save", "mortes", 0);
	var _nome			= ini_read_string("save", "sala", "rVelho");
	ini_close();
	
	global.hp = global.hp_max;
	
	var _sala = asset_get_index(_nome);
	if(_sala == -1 || !room_exists(_sala)) _sala = rVelho;
	room_goto(_sala);
}
