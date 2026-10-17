if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

alpha	= 0;
timer	= 0;

var _frases = [
	"Só mais uma rodada...",
	"A casa sempre vence.",
	"Imortal, mas falido.",
	"Dessa vez a sorte vira.",
	"O velho está esperando."
];
frase = _frases[irandom(array_length(_frases) - 1)];

audio_play_sound(mVoltar, 1, false);
