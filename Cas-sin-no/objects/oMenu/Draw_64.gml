var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;

//Título
ui_texto(_cx, _gh * .2, "CAS-SIN-NO", c_yellow, 4);
ui_texto(_cx, _gh * .2 + 64, "One more time...", c_gray, 1.5);

//Itens (botões clicáveis)
var _n = n_itens();
for(var i = 0; i < _n; i++){
	var _r		= rect_item(i);
	var _ativo	= true;
	var _txt;
	
	if(estado == 0){
		_txt = principal[i];
		//"Carregar" fica apagado se não existe save
		if(i == 1 && !tem_save) _ativo = false;
	}else if(i == 0){
		_txt = "-     Volume: " + string(round(global.volume * 100)) + "%     +";
	}else{
		_txt = "Voltar";
	}
	
	ui_desenhar_botao(_r.x, _r.y, _r.w, _r.h, _txt, _ativo, (i == sel), 1.5);
}

if(aviso > 0) ui_texto(_cx, _gh * .46 + 4 * 62 + 10, "Nenhum jogo salvo ainda!", c_red, 1.2);

ui_texto(_cx, _gh - 30, "Mouse ou W/S + ENTER   |   A/D ajustar volume   |   ESC voltar", c_dkgray, 1);
