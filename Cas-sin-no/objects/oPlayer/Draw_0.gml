//Rastro do dash
if(dash_t > 0){
	for(var i = 1; i <= 3; i++){
		draw_sprite_ext(sprite_index, image_index, x - dir * i * 9, y, image_xscale, image_yscale, 0, c_aqua, .4 / i);
	}
}

draw_self();

//Arco do soco
if(atk_vis > 0){
	var _alc	= alcance_soco();
	var _base	= (dir > 0) ? 0 : 180;
	var _cy		= y - 20;
	
	draw_set_alpha(atk_vis / 8);
	draw_set_color(c_white);
	for(var a = -50; a < 50; a += 10){
		var _a1 = _base + a, _a2 = _base + a + 10;
		draw_line_width(x + lengthdir_x(_alc * .85, _a1), _cy + lengthdir_y(_alc * .85, _a1),
						x + lengthdir_x(_alc * .85, _a2), _cy + lengthdir_y(_alc * .85, _a2), 3);
		draw_line_width(x + lengthdir_x(_alc * .55, _a1), _cy + lengthdir_y(_alc * .55, _a1),
						x + lengthdir_x(_alc * .55, _a2), _cy + lengthdir_y(_alc * .55, _a2), 2);
	}
	
	//Debug: mostra a área real do soco
	if(global.debug){
		draw_set_color(c_red);
		draw_rectangle(x - dir * 8, y - 46, x + dir * _alc, y + 6, true);
	}
	draw_set_alpha(1);
	draw_set_color(c_white);
}
