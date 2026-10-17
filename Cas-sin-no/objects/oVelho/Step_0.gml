if(!aberto){
	//Perto do velho + E = abre a loja (e congela o jogo)
	if(jogador_perto(x + 16, y + 16, 48, 48) && keyboard_check_pressed(ord("E")) && !global.pausado){
		aberto			= true;
		global.pausado	= true;
		sel				= 0;
	}
}else{
	sel = clamp(sel + keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up), 0, array_length(loja) - 1);
	
	if(keyboard_check_pressed(vk_enter)){
		var _item = loja[sel];
		
		if(global.almas >= _item.custo){
			global.almas -= _item.custo;
			audio_play_sound(mPower_up, 1, false);
			
			switch(_item.tipo){
				case "hp":
					global.hp_max	+= 2;
					global.hp		= global.hp_max;
				break;
				case "dmg":
					global.dmg_bonus += 1;
				break;
				case "cura":
					global.hp = global.hp_max;
				break;
			}
		}else{
			audio_play_sound(mVoltar, 1, false);
		}
	}
	
	//Fecha a loja
	if(keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("E"))){
		aberto			= false;
		global.pausado	= false;
	}
}
