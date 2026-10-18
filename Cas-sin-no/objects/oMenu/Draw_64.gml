var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;

if(estado == 0){
	//Título
	ui_texto(_cx, _gh * .17, "CAS-SIN-NO", c_yellow, 4);
	ui_texto(_cx, _gh * .17 + 64, "One more time...", c_gray, 1.5);
}else{
	//Créditos (fonte com acentos antes de escrever)
	draw_set_font(fMenu);
	ui_texto(_cx, _gh * .2, "CRÉDITOS", c_yellow, 3);
	
	for(var c = 0; c < array_length(creditos); c++){
		var _y = _gh * .34 + c * 72;
		ui_texto(_cx, _y, creditos[c][0], c_gray, 1);
		ui_texto(_cx, _y + 26, creditos[c][1], c_white, 1.5);
	}
}

//Itens (botões clicáveis)
var _n = n_itens();
for(var i = 0; i < _n; i++){
	var _r		= rect_item(i);
	var _ativo	= true;
	var _txt;
	//Fonte
	draw_set_font(fMenu);
	
	if(estado == 0){
		if(i == 2){
			_txt = "-     Volume: " + string(round(global.volume * 100)) + "%     +";
		}else{
			_txt = principal[i];
		}
		//"Carregar" fica apagado se não existe save
		if(i == 1 && !tem_save) _ativo = false;
	}else{
		_txt = "Voltar";
	}
	
	ui_desenhar_botao(_r.x, _r.y, _r.w, _r.h, _txt, _ativo, (i == sel), 1.5);
}

if(estado == 0 && aviso > 0) ui_texto(_cx, _gh * .42 + 5 * 60 + 10, "Nenhum jogo salvo ainda!", c_red, 1.2);

var _ajuda = (estado == 0) ? "Mouse ou setas / W A S D + ENTER   |   Volume: setas ou A/D" : "ENTER ou ESC para voltar";
ui_texto(_cx, _gh - 30, _ajuda, c_dkgray, 1);

draw_set_font(-1)