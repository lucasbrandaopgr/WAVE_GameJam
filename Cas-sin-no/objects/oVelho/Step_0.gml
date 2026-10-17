if(distance_to_object(oPlayer) < 40 && keyboard_check_pressed(ord("E"))) aberto = !aberto;

if(aberto){
	sel += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	sel = clamp(sel, 0, array_length(loja) - 1);
	
	if(keyboard_check_pressed(vk_enter)){
		var _item = loja[sel];
		if(global.almas >= _item.custo){
			global.almas -= _item.custo;
			audio_play_sound(mPower_up, 1, false);
			
			if(_item.tipo == "hp"){
				global.hp_max	+= 2;
				global.hp		= global.hp_max;
			}
			if(_item.tipo == "dmg") global.dmg_bonus += 1;
		}
	}
}