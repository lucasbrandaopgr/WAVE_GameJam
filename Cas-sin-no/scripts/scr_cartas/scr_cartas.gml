//=====================================================
// scr_cartas - baralho, avaliação de mãos e desenho
// Carta = número de 0 a 51:  rank = c mod 13 (0 = "2" ... 8 = "10", 9 = J, 10 = Q, 11 = K, 12 = A)
//                            naipe = c div 13 (0 espadas, 1 copas, 2 ouros, 3 paus)
//=====================================================

function baralho_novo(){
	var _b = [];
	for(var i = 0; i < 52; i++) array_push(_b, i);
	
	//Embaralha (Fisher-Yates)
	for(var i = 51; i > 0; i--){
		var _j = irandom(i);
		var _t = _b[i];
		_b[i] = _b[_j];
		_b[_j] = _t;
	}
	return _b;
}

function carta_rank(_c){ return _c mod 13; }
function carta_naipe(_c){ return _c div 13; }

function carta_nome(_c){
	var _n = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"];
	return _n[_c mod 13];
}

//Valor do blackjack (ás vale 11 ou 1)
function bj_valor(_mao){
	var _total = 0;
	var _ases = 0;
	
	for(var i = 0; i < array_length(_mao); i++){
		var _r = _mao[i] mod 13;
		if(_r == 12){
			_ases++;
			_total += 11;
		}else if(_r >= 8){
			_total += 10;
		}else{
			_total += _r + 2;
		}
	}
	
	while(_total > 21 && _ases > 0){
		_total -= 10;
		_ases--;
	}
	return _total;
}

//Tipos de mão do poker (índice = tipo)
function poker_nomes(){
	return ["Nada", "Par de Valetes+", "Dois Pares", "Trinca", "Sequência", "Flush", "Full House", "Quadra", "Straight Flush", "Royal Flush"];
}

//Quantas vezes a aposta volta em cada tipo de mão
function poker_pagamentos(){
	return [0, 1, 2, 3, 4, 6, 9, 25, 50, 250];
}

//Retorna o tipo da mão (0 a 9). Funciona com 5 cartas.
function poker_avaliar(_mao){
	var _cnt = array_create(13, 0);
	var _nai = array_create(4, 0);
	
	for(var i = 0; i < array_length(_mao); i++){
		_cnt[_mao[i] mod 13] += 1;
		_nai[_mao[i] div 13] += 1;
	}
	
	var _flush = false;
	for(var s = 0; s < 4; s++){
		if(_nai[s] == 5) _flush = true;
	}
	
	var _pares = 0, _trinca = false, _quadra = false, _par_alto = false, _distintos = 0;
	var _min = -1, _max = -1;
	for(var r = 0; r < 13; r++){
		if(_cnt[r] > 0){
			_distintos++;
			if(_min == -1) _min = r;
			_max = r;
		}
		if(_cnt[r] == 2){
			_pares++;
			if(r >= 9) _par_alto = true;	//J, Q, K, A
		}
		if(_cnt[r] == 3) _trinca = true;
		if(_cnt[r] == 4) _quadra = true;
	}
	
	var _seq = false;
	if(_distintos == 5){
		if(_max - _min == 4) _seq = true;
		//A-2-3-4-5
		if(_cnt[12] > 0 && _cnt[0] > 0 && _cnt[1] > 0 && _cnt[2] > 0 && _cnt[3] > 0) _seq = true;
	}
	
	if(_flush && _seq && _min == 8 && _max == 12) return 9;	//Royal
	if(_flush && _seq)				return 8;
	if(_quadra)						return 7;
	if(_trinca && _pares == 1)		return 6;
	if(_flush)						return 5;
	if(_seq)						return 4;
	if(_trinca)						return 3;
	if(_pares == 2)					return 2;
	if(_pares == 1 && _par_alto)	return 1;
	return 0;
}

//Pesos dos símbolos do caça-níquel (0 cereja, 1 limão, 2 sino, 3 diamante, 4 barra, 5 sete)
function slot_sortear(){
	var _r = irandom(99);
	if(_r < 30) return 0;
	if(_r < 55) return 1;
	if(_r < 73) return 2;
	if(_r < 85) return 3;
	if(_r < 95) return 4;
	return 5;
}

//Quantas vezes a aposta volta no caça-níquel
function slot_pagamento(_a, _b, _c){
	if(_a == _b && _b == _c){
		var _tab = [6, 10, 20, 40, 60, 200];
		return _tab[_a];
	}
	//Duas cerejas (em qualquer posição)
	var _ch = (_a == 0) + (_b == 0) + (_c == 0);
	if(_ch == 2) return 2;
	return 0;
}

//--- DESENHO ---------------------------------------------------

//Desenha o naipe com formas simples (a fonte padrão não tem ♠♥♦♣)
function draw_naipe(_cx, _cy, _n, _t){
	draw_set_color((_n == 1 || _n == 2) ? make_colour_rgb(210, 20, 30) : c_black);
	
	switch(_n){
		case 0:	//Espadas
			draw_triangle(_cx, _cy - _t, _cx - _t, _cy + _t * .25, _cx + _t, _cy + _t * .25, false);
			draw_circle(_cx - _t * .5, _cy + _t * .2, _t * .5, false);
			draw_circle(_cx + _t * .5, _cy + _t * .2, _t * .5, false);
			draw_triangle(_cx, _cy, _cx - _t * .35, _cy + _t, _cx + _t * .35, _cy + _t, false);
		break;
		case 1:	//Copas
			draw_circle(_cx - _t * .5, _cy - _t * .3, _t * .5, false);
			draw_circle(_cx + _t * .5, _cy - _t * .3, _t * .5, false);
			draw_triangle(_cx - _t, _cy - _t * .1, _cx + _t, _cy - _t * .1, _cx, _cy + _t, false);
		break;
		case 2:	//Ouros
			draw_triangle(_cx, _cy - _t, _cx - _t * .7, _cy, _cx + _t * .7, _cy, false);
			draw_triangle(_cx, _cy + _t, _cx - _t * .7, _cy, _cx + _t * .7, _cy, false);
		break;
		case 3:	//Paus
			draw_circle(_cx, _cy - _t * .45, _t * .42, false);
			draw_circle(_cx - _t * .5, _cy + _t * .1, _t * .42, false);
			draw_circle(_cx + _t * .5, _cy + _t * .1, _t * .42, false);
			draw_triangle(_cx, _cy, _cx - _t * .35, _cy + _t, _cx + _t * .35, _cy + _t, false);
		break;
	}
	draw_set_color(c_white);
}

//Carta com canto superior esquerdo em (_x, _y). Tamanho 80x112.
function draw_carta(_x, _y, _c, _virada = false, _destaque = false){
	var _w = 80, _h = 112;
	
	//Sombra
	draw_set_alpha(.35);
	draw_set_color(c_black);
	draw_roundrect(_x + 4, _y + 5, _x + _w + 4, _y + _h + 5, false);
	draw_set_alpha(1);
	
	if(_virada){
		draw_set_color(make_colour_rgb(30, 50, 140));
		draw_roundrect(_x, _y, _x + _w, _y + _h, false);
		draw_set_color(make_colour_rgb(80, 110, 220));
		draw_roundrect(_x + 6, _y + 6, _x + _w - 6, _y + _h - 6, true);
		draw_roundrect(_x + 12, _y + 12, _x + _w - 12, _y + _h - 12, true);
		draw_set_color(c_white);
		draw_roundrect(_x, _y, _x + _w, _y + _h, true);
		return;
	}
	
	draw_set_color(c_white);
	draw_roundrect(_x, _y, _x + _w, _y + _h, false);
	draw_set_color(_destaque ? c_yellow : c_black);
	draw_roundrect(_x, _y, _x + _w, _y + _h, true);
	if(_destaque) draw_roundrect(_x + 1, _y + 1, _x + _w - 1, _y + _h - 1, true);
	
	var _n		= carta_naipe(_c);
	var _cor	= (_n == 1 || _n == 2) ? make_colour_rgb(210, 20, 30) : c_black;
	var _nome	= carta_nome(_c);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(_cor);
	draw_text_transformed(_x + 15, _y + 16, _nome, 1.3, 1.3, 0);
	draw_text_transformed(_x + _w - 15, _y + _h - 16, _nome, 1.3, 1.3, 180);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	draw_naipe(_x + _w / 2, _y + _h / 2 + 2, _n, 22);
	draw_set_color(c_white);
}

//Dado com pontinhos. (_cx, _cy) = centro, _t = lado
function draw_dado(_cx, _cy, _t, _v){
	draw_set_color(c_white);
	draw_roundrect(_cx - _t / 2, _cy - _t / 2, _cx + _t / 2, _cy + _t / 2, false);
	draw_set_color(c_black);
	draw_roundrect(_cx - _t / 2, _cy - _t / 2, _cx + _t / 2, _cy + _t / 2, true);
	
	var _d = _t * .26;
	var _r = _t * .09;
	var _p = [];	//posições dos pontos: 0 = centro, 1..4 = cantos, 5/6 = laterais
	switch(_v){
		case 1: _p = [[0, 0]]; break;
		case 2: _p = [[-1, -1], [1, 1]]; break;
		case 3: _p = [[-1, -1], [0, 0], [1, 1]]; break;
		case 4: _p = [[-1, -1], [1, -1], [-1, 1], [1, 1]]; break;
		case 5: _p = [[-1, -1], [1, -1], [0, 0], [-1, 1], [1, 1]]; break;
		default: _p = [[-1, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [1, 1]]; break;
	}
	for(var i = 0; i < array_length(_p); i++){
		draw_circle(_cx + _p[i][0] * _d, _cy + _p[i][1] * _d, _r, false);
	}
	draw_set_color(c_white);
}

//Símbolo do caça-níquel centrado em (_cx, _cy)
function draw_simbolo_slot(_cx, _cy, _s){
	switch(_s){
		case 0:	//Cereja
			draw_set_color(c_green);
			draw_line_width(_cx - 14, _cy + 12, _cx + 2, _cy - 30, 3);
			draw_line_width(_cx + 14, _cy + 12, _cx + 2, _cy - 30, 3);
			draw_set_color(c_red);
			draw_circle(_cx - 14, _cy + 14, 16, false);
			draw_circle(_cx + 14, _cy + 14, 16, false);
			draw_set_color(c_white);
			draw_circle(_cx - 19, _cy + 9, 4, false);
			draw_circle(_cx + 9, _cy + 9, 4, false);
		break;
		case 1:	//Limão
			draw_set_color(c_yellow);
			draw_ellipse(_cx - 36, _cy - 24, _cx + 36, _cy + 24, false);
			draw_set_color(c_orange);
			draw_ellipse(_cx - 36, _cy - 24, _cx + 36, _cy + 24, true);
		break;
		case 2:	//Sino
			draw_set_color(make_colour_rgb(240, 190, 30));
			draw_circle(_cx, _cy - 8, 26, false);
			draw_rectangle(_cx - 26, _cy - 8, _cx + 26, _cy + 20, false);
			draw_rectangle(_cx - 32, _cy + 16, _cx + 32, _cy + 24, false);
			draw_set_color(c_orange);
			draw_circle(_cx, _cy + 30, 8, false);
		break;
		case 3:	//Diamante
			draw_set_color(c_aqua);
			draw_triangle(_cx, _cy - 36, _cx - 34, _cy - 6, _cx + 34, _cy - 6, false);
			draw_triangle(_cx, _cy + 36, _cx - 34, _cy - 6, _cx + 34, _cy - 6, false);
			draw_set_color(c_white);
			draw_line(_cx - 34, _cy - 6, _cx + 34, _cy - 6);
			draw_line(_cx - 12, _cy - 6, _cx, _cy - 36);
			draw_line(_cx + 12, _cy - 6, _cx, _cy - 36);
		break;
		case 4:	//BAR
			draw_set_color(c_black);
			draw_rectangle(_cx - 40, _cy - 20, _cx + 40, _cy + 20, false);
			draw_set_color(c_white);
			draw_rectangle(_cx - 40, _cy - 20, _cx + 40, _cy + 20, true);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text_transformed(_cx, _cy, "BAR", 2, 2, 0);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		break;
		case 5:	//Sete
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_black);
			draw_text_transformed(_cx + 3, _cy + 3, "7", 5, 5, 0);
			draw_set_color(c_red);
			draw_text_transformed(_cx, _cy, "7", 5, 5, 0);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		break;
	}
	draw_set_color(c_white);
}
