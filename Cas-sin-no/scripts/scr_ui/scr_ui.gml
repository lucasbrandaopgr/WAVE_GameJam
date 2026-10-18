//=====================================================
// scr_ui - ajudantes de interface (mouse + desenho)
// O oGame fixa o GUI em 1280x720 (display_set_gui_size),
// então todas as telas usam essas coordenadas.
//=====================================================

function ui_mx(){ return device_mouse_x_to_gui(0); }
function ui_my(){ return device_mouse_y_to_gui(0); }

//O mouse está dentro do retângulo?
function ui_sobre(_x, _y, _w, _h){
	var _mx = ui_mx(), _my = ui_my();
	return (_mx >= _x && _mx <= _x + _w && _my >= _y && _my <= _y + _h);
}

function ui_clique(){
	return mouse_check_button_pressed(mb_left);
}

//Só desenha o botão (a lógica de clique fica no Step de quem chama)
function ui_desenhar_botao(_x, _y, _w, _h, _txt, _ativo = true, _destaque = false, _esc = 1.3){
	var _fundo	= make_colour_rgb(45, 45, 58);
	var _borda	= c_white;
	var _texto	= c_white;
	
	if(!_ativo){
		_fundo = make_colour_rgb(28, 28, 32);
		_borda = c_dkgray;
		_texto = c_gray;
	}else if(_destaque){
		_fundo = make_colour_rgb(120, 85, 10);
		_borda = c_yellow;
		_texto = c_yellow;
	}
	
	draw_set_alpha(1);
	draw_set_color(_fundo);
	draw_roundrect(_x, _y, _x + _w, _y + _h, false);
	draw_set_color(_borda);
	draw_roundrect(_x, _y, _x + _w, _y + _h, true);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(_texto);
	draw_text_transformed(_x + _w / 2, _y + _h / 2, _txt, _esc, _esc, 0);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}

//Desenha E detecta clique (para usar dentro de um Draw GUI). Retorna true no clique.
function ui_botao(_x, _y, _w, _h, _txt, _ativo = true, _esc = 1.3){
	var _sobre = _ativo && ui_sobre(_x, _y, _w, _h);
	ui_desenhar_botao(_x, _y, _w, _h, _txt, _ativo, _sobre, _esc);
	return _sobre && mouse_check_button_pressed(mb_left);
}

//Painel escuro com borda
function ui_painel(_x, _y, _w, _h, _alpha = .92){
	draw_set_alpha(_alpha);
	draw_set_color(c_black);
	draw_rectangle(_x, _y, _x + _w, _y + _h, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_rectangle(_x, _y, _x + _w, _y + _h, true);
}

//Texto centralizado com escala
function ui_texto(_x, _y, _txt, _cor = c_white, _esc = 1){
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(_cor);
	draw_text_transformed(_x, _y, _txt, _esc, _esc, 0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}
