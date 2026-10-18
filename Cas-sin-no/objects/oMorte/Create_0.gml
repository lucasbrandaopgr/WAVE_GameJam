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

//Botões clicáveis (0 = mais uma vez, 1 = menu)
rect_botao = function(_i){
	var _gw = display_get_gui_width();
	var _gh = display_get_gui_height();
	return {x: _gw / 2 - 170 + _i * 190 - 0, y: _gh * .78, w: (_i == 0) ? 170 : 150, h: 56};
}
