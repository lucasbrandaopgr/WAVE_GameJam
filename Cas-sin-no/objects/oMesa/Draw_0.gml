//Mesa desenhada por código (troque por sprites quando tiver arte). Origin = chão (x, y).
if(jogo == "slot"){
	//Máquina de caça-níquel
	draw_set_color(make_colour_rgb(150, 20, 30));
	draw_rectangle(x - 18, y - 58, x + 18, y, false);
	draw_set_color(c_yellow);
	draw_rectangle(x - 18, y - 58, x + 18, y, true);
	draw_set_color(c_black);
	draw_rectangle(x - 13, y - 50, x + 13, y - 30, false);
	draw_set_color(c_white);
	draw_rectangle(x - 11, y - 47, x - 5, y - 33, false);
	draw_rectangle(x - 3, y - 47, x + 3, y - 33, false);
	draw_rectangle(x + 5, y - 47, x + 11, y - 33, false);
	draw_set_color(c_red);
	draw_line_width(x + 18, y - 40, x + 26, y - 52, 2);
	draw_circle(x + 26, y - 52, 3, false);
}else{
	//Pernas e tampo
	draw_set_color(make_colour_rgb(70, 40, 20));
	draw_rectangle(x - 26, y - 20, x - 22, y, false);
	draw_rectangle(x + 22, y - 20, x + 26, y, false);
	draw_set_color(cor);
	draw_rectangle(x - 32, y - 28, x + 32, y - 18, false);
	draw_set_color(c_white);
	draw_rectangle(x - 32, y - 28, x + 32, y - 18, true);
	
	switch(jogo){
		case "blackjack":
			draw_set_color(c_white);
			draw_rectangle(x - 14, y - 40, x - 4, y - 28, false);
			draw_rectangle(x + 2, y - 40, x + 12, y - 28, false);
			draw_set_color(c_red);
			draw_circle(x - 9, y - 34, 2, false);
			draw_set_color(c_black);
			draw_circle(x + 7, y - 34, 2, false);
		break;
		case "poker":
			draw_set_color(c_red);
			draw_circle(x - 10, y - 32, 5, false);
			draw_set_color(c_blue);
			draw_circle(x, y - 32, 5, false);
			draw_set_color(c_black);
			draw_circle(x + 10, y - 32, 5, false);
			draw_set_color(c_white);
			draw_circle(x - 10, y - 32, 5, true);
			draw_circle(x, y - 32, 5, true);
			draw_circle(x + 10, y - 32, 5, true);
		break;
		case "dados":
			draw_set_color(c_white);
			draw_rectangle(x - 14, y - 40, x - 4, y - 30, false);
			draw_rectangle(x + 4, y - 40, x + 14, y - 30, false);
			draw_set_color(c_black);
			draw_circle(x - 9, y - 35, 1.5, false);
			draw_circle(x + 9, y - 35, 1.5, false);
		break;
	}
}

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(x, y - 70, nome, .6, .6, 0);

if(!global.pausado && !instance_exists(oCassino) && jogador_perto(x, y - 24, 44, 44)){
	draw_set_color(c_yellow);
	draw_text_transformed(x, y - 84, "[E] Jogar", .6, .6, 0);
}

draw_set_halign(fa_left);
draw_set_color(c_white);
