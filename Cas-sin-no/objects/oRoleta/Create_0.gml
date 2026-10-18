//Origin = pé da máquina (x, y no chão)
custo		= 5;	//Moedas por giro
estado		= 0;	//0 = parada, 1 = girando, 2 = mostrando resultado
ang			= 0;
ang_alvo	= 0;
resultado	= 0;
timer		= 0;
aviso		= 0;

//Fatias da roleta (4 boas, 4 ruins). Pra mudar a sorte, repita fatias.
fatias = [
	{nome: "VELOZ",		desc: "Velocidade +50% por 15s",	cor: c_green},
	{nome: "DANO x2",	desc: "Dano dobrado por 15s",		cor: c_lime},
	{nome: "CURA",		desc: "Vida cheia!",				cor: c_aqua},
	{nome: "+10",		desc: "Ganhou 10 moedas",			cor: c_yellow},
	{nome: "LENTO",		desc: "Velocidade -50% por 15s",	cor: c_maroon},
	{nome: "FRACO",		desc: "Dano pela metade por 15s",	cor: c_red},
	{nome: "-3 HP",		desc: "Perdeu 3 de vida",			cor: c_orange},
	{nome: "-5",		desc: "Perdeu 5 moedas",			cor: c_purple}
];
n_fatias = array_length(fatias);

//Aplica o efeito da fatia sorteada (a roleta nunca mata: HP mínimo 1)
aplicar = function(_i){
	switch(_i){
		case 0:
			global.buff_vel = 1.5;	global.buff_dmg = 1;
			global.buff_timer = 900;	global.buff_nome = "Veloz";
			audio_play_sound(mPower_up, 1, false);
		break;
		case 1:
			global.buff_vel = 1;	global.buff_dmg = 2;
			global.buff_timer = 900;	global.buff_nome = "Dano x2";
			audio_play_sound(mPower_up, 1, false);
		break;
		case 2:
			global.hp = global.hp_max;
			audio_play_sound(mPower_up, 1, false);
		break;
		case 3:
			global.moedas += 10;
			audio_play_sound(mMoeda, 1, false);
		break;
		case 4:
			global.buff_vel = .5;	global.buff_dmg = 1;
			global.buff_timer = 900;	global.buff_nome = "Lento";
			audio_play_sound(mVoltar, 1, false);
		break;
		case 5:
			global.buff_vel = 1;	global.buff_dmg = .5;
			global.buff_timer = 900;	global.buff_nome = "Fraco";
			audio_play_sound(mVoltar, 1, false);
		break;
		case 6:
			global.hp = max(1, global.hp - 3);
			audio_play_sound(mSoco, 1, false);
		break;
		case 7:
			global.moedas = max(0, global.moedas - 5);
			audio_play_sound(mVoltar, 1, false);
		break;
	}
}
