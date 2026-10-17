var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw / 2;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Título
draw_set_color(c_yellow);
draw_text_transformed(_cx, _gh * .22, "CAS-SIN-NO", 4, 4, 0);
draw_set_color(c_gray);
draw_text_transformed(_cx, _gh * .22 + 64, "One more time...", 1.5, 1.5, 0);

//Itens
var _lista;
if(estado == 0){
	_lista = principal;
}else{
	_lista = ["Volume: " + string(round(global.volume * 100)) + "%", "Voltar"];
}

for(var i = 0; i < array_length(_lista); i++){
	var _cor = (i == sel) ? c_yellow : c_white;
	
	//"Carregar" fica apagado se não existe save
	if(estado == 0 && i == 1 && !tem_save) _cor = (i == sel) ? c_gray : c_dkgray;
	
	draw_set_color(_cor);
	var _txt = (i == sel) ? "> " + _lista[i] + " <" : _lista[i];
	draw_text_transformed(_cx, _gh * .5 + i * 50, _txt, 2, 2, 0);
}

if(aviso > 0){
	draw_set_color(c_red);
	draw_text(_cx, _gh * .5 + 190, "Nenhum jogo salvo ainda!");
}

draw_set_color(c_dkgray);
draw_text(_cx, _gh - 30, "W/S navegar   |   ENTER confirmar   |   A/D ajustar   |   ESC voltar");

//Volta o estado padrão do desenho
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
