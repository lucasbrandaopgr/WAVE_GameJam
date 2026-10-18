if(aviso > 0) aviso--;

if(!aberto){
	//Perto do velho + E (ou clique nele) = abre a loja (e congela o jogo)
	if(jogador_perto(x + 16, y + 16, 48, 48) && keyboard_check_pressed(ord("E")) && !global.pausado){
		aberto			= true;
		global.pausado	= true;
		sel				= 0;
	}
}else{
	var _n		= array_length(loja);
	var _clique	= mouse_check_button_pressed(mb_left);
	var _mexeu	= (ui_mx() != mx_ant || ui_my() != my_ant);
	mx_ant = ui_mx();
	my_ant = ui_my();
	
	sel = clamp(sel + keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up), 0, _n - 1);
	var _comprar = keyboard_check_pressed(vk_enter);
	
	//Mouse: passar por cima seleciona, clicar compra
	for(var i = 0; i < _n; i++){
		var _r = linha_rect(i);
		if(ui_sobre(_r.x, _r.y, _r.w, _r.h)){
			if(_mexeu || _clique) sel = i;
			if(_clique) _comprar = true;
		}
	}
	
	if(_comprar) comprar(sel);
	
	//Fecha a loja (E, ESC ou botão Sair)
	var _s = sair_rect();
	var _sair = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("E"))
		|| (_clique && ui_sobre(_s.x, _s.y, _s.w, _s.h));
	
	if(_sair){
		aberto = false;
		modal_fechou();
	}
}
