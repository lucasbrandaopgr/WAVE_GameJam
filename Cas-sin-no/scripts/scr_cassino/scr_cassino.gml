//=====================================================
// scr_cassino - minigames: Blackjack (21), Poker, Caça-níquel e Dados
// Cada jogo é um struct com: passo() (teclado), desenhar() (desenho + mouse),
// pode_sair() e a flag fechar. O objeto oCassino só roda isso.
// Regra de dinheiro: a aposta sai das moedas ao começar; o prêmio (já com a
// aposta de volta) entra no fim da rodada.
//=====================================================

//--- Ajudantes comuns ----------------------------------------

function cas_aposta_clamp(_g){
	_g.aposta = clamp(_g.aposta, 1, max(1, global.moedas));
}

//Moldura, título, moedas e botão Sair. Retorna true se clicou em Sair.
function cas_cabecalho(_titulo, _pode_sair){
	var _gw = display_get_gui_width();
	var _cx = _gw / 2;
	
	//Fundo escurecido do jogo
	draw_set_alpha(.7);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gw, display_get_gui_height(), false);
	draw_set_alpha(1);
	
	ui_painel(40, 30, _gw - 80, 660, 1);
	
	//Feltro
	draw_set_color(make_colour_rgb(16, 84, 42));
	draw_roundrect(56, 88, _gw - 56, 674, false);
	draw_set_color(make_colour_rgb(30, 130, 70));
	draw_roundrect(56, 88, _gw - 56, 674, true);
	
	ui_texto(_cx, 58, _titulo, c_yellow, 2);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text_transformed(_gw - 60, 58, "Moedas: " + string(global.moedas), 1.5, 1.5, 0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	return ui_botao(60, 40, 150, 36, "Sair (ESC)", _pode_sair, 1);
}

//Linha de aposta + botão de começar. Retorna true se clicou em começar.
function cas_ui_aposta(_g, _y, _txt){
	var _cx = display_get_gui_width() / 2;
	var _sem = (global.moedas < 1);
	
	ui_texto(_cx - 330, _y + 22, "APOSTA", c_white, 1.2);
	if(ui_botao(_cx - 250, _y, 60, 44, "-5", true, 1.1)) _g.aposta -= 5;
	if(ui_botao(_cx - 184, _y, 60, 44, "-1", true, 1.1)) _g.aposta -= 1;
	ui_texto(_cx, _y + 22, string(_g.aposta), c_yellow, 2.2);
	if(ui_botao(_cx + 124, _y, 60, 44, "+1", true, 1.1)) _g.aposta += 1;
	if(ui_botao(_cx + 190, _y, 60, 44, "+5", true, 1.1)) _g.aposta += 5;
	if(ui_botao(_cx + 256, _y, 90, 44, "MAX", true, 1.1)) _g.aposta = global.moedas;
	cas_aposta_clamp(_g);
	
	if(_sem) ui_texto(_cx, _y + 124, "Sem moedas! Derrote inimigos para ganhar mais.", c_red, 1);
	
	return ui_botao(_cx - 120, _y + 56, 240, 52, _txt, !_sem, 1.4);
}

//Teclas de apostar (esq/dir = 1, cima/baixo = 5). Retorna true se apertou ENTER/ESPAÇO.
function cas_teclas_aposta(_g){
	var _d = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)
		+ 5 * (keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down));
	if(_d != 0){
		_g.aposta += _d;
		cas_aposta_clamp(_g);
	}
	return keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
}

//Mensagem de resultado
function cas_mensagem(_g, _y){
	if(_g.msg != "") ui_texto(display_get_gui_width() / 2, _y, _g.msg, _g.msg_cor, 2);
}

//Aplica o prêmio e prepara a mensagem. _pago = total que volta (aposta inclusa)
function cas_resultado(_g, _pago, _txt_ganhou, _txt_perdeu, _txt_empate = ""){
	global.moedas += _pago;
	_g.liquido = _pago - _g.em_jogo;
	
	if(_g.liquido > 0){
		_g.msg = _txt_ganhou + "  +" + string(_g.liquido);
		_g.msg_cor = c_lime;
		audio_play_sound(mMoeda, 1, false);
	}else if(_g.liquido == 0){
		_g.msg = (_txt_empate == "") ? _txt_perdeu : _txt_empate;
		_g.msg_cor = c_white;
	}else{
		_g.msg = _txt_perdeu + "  " + string(_g.liquido);
		_g.msg_cor = c_red;
		audio_play_sound(mVoltar, 1, false);
	}
}

//--- BLACKJACK -----------------------------------------------

function JogoBlackjack() constructor {
	aposta		= 5;
	em_jogo		= 0;
	fase		= 0;	//0 apostando | 1 sua vez | 2 vez da casa | 3 resultado
	timer		= 0;
	liquido		= 0;
	msg			= "";
	msg_cor		= c_white;
	fechar		= false;
	baralho		= [];
	jogador		= [];
	dealer		= [];
	esconder	= true;
	dobrou		= false;
	
	aposta = clamp(aposta, 1, max(1, global.moedas));
	
	pode_sair = function(){
		return (fase == 0 || fase == 3);
	}
	
	iniciar = function(){
		if(global.moedas < aposta || aposta < 1) return;
		
		global.moedas	-= aposta;
		em_jogo			= aposta;
		baralho			= baralho_novo();
		jogador			= [];
		dealer			= [];
		array_push(jogador,	array_pop(baralho));
		array_push(dealer,	array_pop(baralho));
		array_push(jogador,	array_pop(baralho));
		array_push(dealer,	array_pop(baralho));
		esconder	= true;
		dobrou		= false;
		msg			= "";
		fase		= 1;
		audio_play_sound(mPulo, 1, false);
		
		//Blackjack natural de alguém: acaba na hora
		if(bj_valor(jogador) == 21 || bj_valor(dealer) == 21) resolver();
	}
	
	pedir = function(){
		if(fase != 1) return;
		array_push(jogador, array_pop(baralho));
		audio_play_sound(mPulo, 1, false);
		
		var _v = bj_valor(jogador);
		if(_v > 21) resolver();
		else if(_v == 21) parar();
	}
	
	parar = function(){
		if(fase != 1) return;
		fase		= 2;
		esconder	= false;
		timer		= 30;
	}
	
	dobrar = function(){
		if(fase != 1 || array_length(jogador) != 2 || global.moedas < em_jogo) return;
		global.moedas	-= em_jogo;
		em_jogo			*= 2;
		dobrou			 = true;
		array_push(jogador, array_pop(baralho));
		audio_play_sound(mPulo, 1, false);
		
		if(bj_valor(jogador) > 21) resolver();
		else parar();
	}
	
	resolver = function(){
		fase		= 3;
		esconder	= false;
		
		var _j		= bj_valor(jogador);
		var _d		= bj_valor(dealer);
		var _jbj	= (array_length(jogador) == 2 && _j == 21);
		var _dbj	= (array_length(dealer) == 2 && _d == 21);
		
		if(_j > 21){
			cas_resultado(self, 0, "", "ESTOUROU!");
		}else if(_jbj && !_dbj){
			cas_resultado(self, em_jogo + floor(em_jogo * 1.5), "BLACKJACK!", "");
		}else if(_dbj && !_jbj){
			cas_resultado(self, 0, "", "BLACKJACK DA CASA");
		}else if(_d > 21){
			cas_resultado(self, em_jogo * 2, "A CASA ESTOUROU!", "");
		}else if(_j > _d){
			cas_resultado(self, em_jogo * 2, "VOCÊ VENCEU!", "");
		}else if(_j == _d){
			cas_resultado(self, em_jogo, "", "EMPATE", "EMPATE (aposta devolvida)");
		}else{
			cas_resultado(self, 0, "", "A CASA VENCEU");
		}
	}
	
	passo = function(){
		var _p;
		switch(fase){
			case 0:
			case 3:
				_p = cas_teclas_aposta(self);
				if(_p) iniciar();
			break;
			case 1:
				if(keyboard_check_pressed(ord("H"))) pedir();
				if(keyboard_check_pressed(ord("S"))) parar();
				if(keyboard_check_pressed(ord("D"))) dobrar();
			break;
			case 2:
				//A casa compra até 17, uma carta de cada vez
				timer--;
				if(timer <= 0){
					if(bj_valor(dealer) < 17){
						array_push(dealer, array_pop(baralho));
						audio_play_sound(mPulo, 1, false);
						timer = 35;
					}else{
						resolver();
					}
				}
			break;
		}
	}
	
	desenhar = function(){
		if(cas_cabecalho("BLACKJACK  -  21", pode_sair())) fechar = true;
		
		var _cx = display_get_gui_width() / 2;
		
		//Mão da casa
		var _n = array_length(dealer);
		if(_n > 0){
			ui_texto(_cx, 112, "CASA" + (esconder ? "" : "   (" + string(bj_valor(dealer)) + ")"), c_white, 1.2);
			var _x0 = _cx - (_n * 92 - 12) / 2;
			for(var i = 0; i < _n; i++) draw_carta(_x0 + i * 92, 130, dealer[i], esconder && i == 1);
		}
		
		//Mão do jogador
		_n = array_length(jogador);
		if(_n > 0){
			ui_texto(_cx, 358, "VOCÊ   (" + string(bj_valor(jogador)) + ")", c_white, 1.2);
			var _x1 = _cx - (_n * 92 - 12) / 2;
			for(var i = 0; i < _n; i++) draw_carta(_x1 + i * 92, 376, jogador[i]);
		}else{
			ui_texto(_cx, 300, "Faça sua aposta e a casa distribui as cartas", c_ltgray, 1.3);
			ui_texto(_cx, 340, "Blackjack paga 3 para 2   |   A casa compra até 17", c_ltgray, 1);
		}
		
		if(fase == 3) cas_mensagem(self, 310);
		
		if(fase == 0 || fase == 3){
			if(cas_ui_aposta(self, 530, "DISTRIBUIR")) iniciar();
		}else if(fase == 1){
			if(ui_botao(_cx - 330, 560, 200, 60, "PEDIR (H)")) pedir();
			if(ui_botao(_cx - 100, 560, 200, 60, "PARAR (S)")) parar();
			var _pode_dobrar = (array_length(jogador) == 2 && global.moedas >= em_jogo);
			if(ui_botao(_cx + 130, 560, 200, 60, "DOBRAR (D)", _pode_dobrar)) dobrar();
			ui_texto(_cx, 530, "Aposta na mesa: " + string(em_jogo), c_yellow, 1.1);
		}else{
			ui_texto(_cx, 585, "A casa está jogando...", c_ltgray, 1.3);
		}
	}
}

//--- POKER (vídeo poker: 5 cartas, troque as que quiser) ------

function JogoPoker() constructor {
	aposta		= 5;
	em_jogo		= 0;
	fase		= 0;	//0 apostando | 1 escolher cartas | 2 resultado
	liquido		= 0;
	msg			= "";
	msg_cor		= c_white;
	fechar		= false;
	baralho		= [];
	mao			= [];
	seguro		= [false, false, false, false, false];
	tipo		= 0;
	
	aposta = clamp(aposta, 1, max(1, global.moedas));
	
	pode_sair = function(){
		return (fase != 1);
	}
	
	iniciar = function(){
		if(global.moedas < aposta || aposta < 1) return;
		
		global.moedas	-= aposta;
		em_jogo			= aposta;
		baralho			= baralho_novo();
		mao				= [];
		for(var i = 0; i < 5; i++){
			array_push(mao, array_pop(baralho));
			seguro[i] = false;
		}
		msg		= "";
		fase	= 1;
		audio_play_sound(mPulo, 1, false);
	}
	
	trocar = function(){
		if(fase != 1) return;
		for(var i = 0; i < 5; i++){
			if(!seguro[i]) mao[i] = array_pop(baralho);
		}
		audio_play_sound(mPulo, 1, false);
		
		fase		= 2;
		tipo		= poker_avaliar(mao);
		var _nomes	= poker_nomes();
		var _pag	= poker_pagamentos();
		
		cas_resultado(self, em_jogo * _pag[tipo], string_upper(_nomes[tipo]) + "!", "SEM JOGO", string_upper(_nomes[tipo]) + " (aposta devolvida)");
	}
	
	passo = function(){
		var _p;
		if(fase == 1){
			for(var i = 0; i < 5; i++){
				if(keyboard_check_pressed(ord("1") + i)) seguro[i] = !seguro[i];
			}
			if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) trocar();
		}else{
			_p = cas_teclas_aposta(self);
			if(_p) iniciar();
		}
	}
	
	desenhar = function(){
		if(cas_cabecalho("POKER  -  Cinco Cartas", pode_sair())) fechar = true;
		
		var _cx = display_get_gui_width() / 2 - 110;
		var _x0 = _cx - 240;
		
		//Cartas
		for(var i = 0; i < 5; i++){
			var _x = _x0 + i * 100;
			var _y = 190;
			
			if(fase == 0){
				draw_carta(_x, _y, 0, true);
			}else{
				if(seguro[i] && fase == 1) _y -= 14;
				draw_carta(_x, _y, mao[i], false, seguro[i] && fase == 1);
				
				if(fase == 1){
					ui_texto(_x + 40, 330, seguro[i] ? "SEGURAR" : "(" + string(i + 1) + ")", seguro[i] ? c_yellow : c_ltgray, 1.1);
					if(ui_sobre(_x, 176, 80, 126) && ui_clique()) seguro[i] = !seguro[i];
				}
			}
		}
		
		//Mão atual (prévia)
		var _nomes = poker_nomes();
		if(fase == 0){
			ui_texto(_cx, 130, "Escolha as cartas que quer SEGURAR, troque o resto", c_ltgray, 1.2);
		}else if(fase == 1){
			var _t = poker_avaliar(mao);
			ui_texto(_cx, 130, "Sua mão: " + _nomes[_t], (_t > 0) ? c_yellow : c_ltgray, 1.4);
			ui_texto(_cx, 360, "Clique nas cartas (ou teclas 1 a 5) para segurar", c_ltgray, 1);
		}else{
			ui_texto(_cx, 130, "Sua mão: " + _nomes[tipo], (tipo > 0) ? c_yellow : c_ltgray, 1.4);
			cas_mensagem(self, 400);
		}
		
		//Tabela de pagamentos
		var _tx = display_get_gui_width() - 330;
		var _pag = poker_pagamentos();
		ui_texto(_tx + 130, 120, "PAGAMENTOS", c_yellow, 1.2);
		var _ativo = (fase == 1) ? poker_avaliar(mao) : ((fase == 2) ? tipo : -1);
		for(var k = 9; k >= 1; k--){
			var _ly = 150 + (9 - k) * 26;
			var _cor = (k == _ativo) ? c_yellow : c_white;
			if(k == _ativo){
				draw_set_alpha(.25);
				draw_set_color(c_yellow);
				draw_rectangle(_tx - 6, _ly - 2, _tx + 266, _ly + 22, false);
				draw_set_alpha(1);
			}
			draw_set_color(_cor);
			draw_text(_tx, _ly, _nomes[k]);
			draw_set_halign(fa_right);
			draw_text(_tx + 260, _ly, "x" + string(_pag[k]));
			draw_set_halign(fa_left);
		}
		draw_set_color(c_white);
		
		if(fase == 1){
			ui_texto(_cx, 530, "Aposta na mesa: " + string(em_jogo), c_yellow, 1.1);
			if(ui_botao(_cx - 130, 560, 260, 60, "TROCAR (ENTER)")) trocar();
		}else{
			if(cas_ui_aposta(self, 530, "DISTRIBUIR")) iniciar();
		}
	}
}

//--- CAÇA-NÍQUEL ---------------------------------------------

function JogoSlot() constructor {
	aposta		= 5;
	em_jogo		= 0;
	fase		= 0;	//0 parado | 1 girando
	timer		= 0;
	liquido		= 0;
	msg			= "";
	msg_cor		= c_white;
	fechar		= false;
	sorteado		= [0, 0, 0];
	atual		= [0, 1, 2];
	parou		= [true, true, true];
	
	aposta = clamp(aposta, 1, max(1, global.moedas));
	
	pode_sair = function(){
		return (fase == 0);
	}
	
	girar = function(){
		if(global.moedas < aposta || aposta < 1 || fase != 0) return;
		
		global.moedas	-= aposta;
		em_jogo			= aposta;
		sorteado			= [slot_sortear(), slot_sortear(), slot_sortear()];
		parou			= [false, false, false];
		timer			= 0;
		fase			= 1;
		msg				= "";
		audio_play_sound(mMoeda, 1, false);
	}
	
	passo = function(){
		var _p;
		if(fase == 0){
			_p = cas_teclas_aposta(self);
			if(_p) girar();
		}else{
			timer++;
			for(var i = 0; i < 3; i++){
				if(timer < 40 + i * 25){
					if(timer mod 3 == 0) atual[i] = irandom(5);
				}else if(!parou[i]){
					parou[i]	= true;
					atual[i]	= sorteado[i];
					audio_play_sound(mPulo, 1, false);
				}
			}
			
			if(parou[0] && parou[1] && parou[2] && timer > 40 + 2 * 25 + 20){
				fase = 0;
				var _mult = slot_pagamento(sorteado[0], sorteado[1], sorteado[2]);
				
				if(sorteado[0] == 5 && sorteado[1] == 5 && sorteado[2] == 5){
					global.hp = global.hp_max;	//Jackpot cura tudo
					cas_resultado(self, em_jogo * _mult, "JACKPOT 777!", "");
				}else if(_mult > 0){
					cas_resultado(self, em_jogo * _mult, "PREMIO x" + string(_mult) + "!", "");
				}else{
					cas_resultado(self, 0, "", "Nada desta vez");
				}
			}
		}
	}
	
	desenhar = function(){
		if(cas_cabecalho("CAÇA-NÍQUEL", pode_sair())) fechar = true;
		
		var _cx = display_get_gui_width() / 2 - 100;
		
		//Máquina
		draw_set_color(make_colour_rgb(120, 20, 30));
		draw_roundrect(_cx - 300, 110, _cx + 300, 370, false);
		draw_set_color(c_yellow);
		draw_roundrect(_cx - 300, 110, _cx + 300, 370, true);
		
		for(var i = 0; i < 3; i++){
			var _rx = _cx + (i - 1) * 190;
			draw_set_color(c_white);
			draw_roundrect(_rx - 80, 135, _rx + 80, 345, false);
			draw_set_color(c_black);
			draw_roundrect(_rx - 80, 135, _rx + 80, 345, true);
			draw_simbolo_slot(_rx, 240, atual[i]);
		}
		
		cas_mensagem(self, 410);
		if(msg == "") ui_texto(_cx, 410, (fase == 1) ? "Girando..." : "Boa sorte!", c_ltgray, 1.5);
		
		//Tabela
		var _tx = display_get_gui_width() - 330;
		ui_texto(_tx + 130, 120, "PAGAMENTOS", c_yellow, 1.2);
		var _pag = [6, 10, 20, 40, 60, 200];
		var _nom = ["Cereja x3", "Limão x3", "Sino x3", "Diamante x3", "BAR x3", "777"];
		for(var k = 5; k >= 0; k--){
			var _ly = 150 + (5 - k) * 28;
			draw_set_color(c_white);
			draw_text(_tx, _ly, _nom[k]);
			draw_set_halign(fa_right);
			draw_text(_tx + 260, _ly, "x" + string(_pag[k]));
			draw_set_halign(fa_left);
		}
		draw_text(_tx, 150 + 6 * 28, "2 Cerejas");
		draw_set_halign(fa_right);
		draw_text(_tx + 260, 150 + 6 * 28, "x2");
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		
		if(fase == 0){
			if(cas_ui_aposta(self, 500, "GIRAR (ENTER)")) girar();
		}else{
			ui_texto(_cx, 560, "Aposta na máquina: " + string(em_jogo), c_yellow, 1.2);
		}
	}
}

//--- DADOS (abaixo / sete / acima) ---------------------------

function JogoDados() constructor {
	aposta		= 5;
	em_jogo		= 0;
	fase		= 0;	//0 apostando | 1 rolando | 2 resultado
	timer		= 0;
	liquido		= 0;
	msg			= "";
	msg_cor		= c_white;
	fechar		= false;
	escolha		= 0;	//0 abaixo de 7 | 1 sete | 2 acima de 7
	d1			= 3;
	d2			= 4;
	f1			= 3;
	f2			= 4;
	
	aposta = clamp(aposta, 1, max(1, global.moedas));
	
	pode_sair = function(){
		return (fase != 1);
	}
	
	lancar = function(){
		if(global.moedas < aposta || aposta < 1 || fase == 1) return;
		
		global.moedas	-= aposta;
		em_jogo			= aposta;
		f1				= irandom_range(1, 6);
		f2				= irandom_range(1, 6);
		timer			= 0;
		fase			= 1;
		msg				= "";
		audio_play_sound(mMoeda, 1, false);
	}
	
	passo = function(){
		var _p;
		if(fase == 1){
			timer++;
			if(timer < 55){
				if(timer mod 4 == 0){
					d1 = irandom_range(1, 6);
					d2 = irandom_range(1, 6);
				}
			}else{
				d1		= f1;
				d2		= f2;
				fase	= 2;
				
				var _soma	= d1 + d2;
				var _ganhou	= (escolha == 0 && _soma < 7) || (escolha == 1 && _soma == 7) || (escolha == 2 && _soma > 7);
				var _mult	= (escolha == 1) ? 6 : 2;
				
				cas_resultado(self, _ganhou ? em_jogo * _mult : 0, "SAIU " + string(_soma) + "!", "SAIU " + string(_soma));
			}
		}else{
			if(keyboard_check_pressed(ord("1"))) escolha = 0;
			if(keyboard_check_pressed(ord("2"))) escolha = 1;
			if(keyboard_check_pressed(ord("3"))) escolha = 2;
			_p = cas_teclas_aposta(self);
			if(_p) lancar();
		}
	}
	
	desenhar = function(){
		if(cas_cabecalho("DADOS  -  Sete da Sorte", pode_sair())) fechar = true;
		
		var _cx = display_get_gui_width() / 2;
		
		//Dados
		draw_dado(_cx - 90, 220, 130, d1);
		draw_dado(_cx + 90, 220, 130, d2);
		ui_texto(_cx, 330, "Soma: " + string(d1 + d2), c_white, 1.4);
		
		cas_mensagem(self, 385);
		
		//Escolha da aposta
		var _ativo = (fase != 1);
		var _nomes = ["ABAIXO de 7  (x2)", "SETE  (x6)", "ACIMA de 7  (x2)"];
		for(var i = 0; i < 3; i++){
			var _bx = _cx - 345 + i * 235;
			var _sel = (escolha == i);
			if(_ativo){
				ui_desenhar_botao(_bx, 430, 220, 54, _nomes[i], true, _sel, 1.1);
				if(ui_sobre(_bx, 430, 220, 54) && ui_clique()) escolha = i;
			}else{
				ui_desenhar_botao(_bx, 430, 220, 54, _nomes[i], _sel, _sel, 1.1);
			}
		}
		ui_texto(_cx, 505, "Teclas 1 / 2 / 3 escolhem   |   Abaixo = 2 a 6   |   Acima = 8 a 12", c_ltgray, 1);
		
		if(fase != 1){
			if(cas_ui_aposta(self, 540, "LANÇAR (ENTER)")) lancar();
		}else{
			ui_texto(_cx, 580, "Rolando...", c_yellow, 1.5);
		}
	}
}
