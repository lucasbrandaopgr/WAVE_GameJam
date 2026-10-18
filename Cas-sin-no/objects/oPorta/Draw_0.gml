draw_self();

draw_set_halign(fa_center);

if(!abrindo && !global.pausado && jogador_perto(x, y - 32, 28, 40)){
	draw_set_color(c_yellow);
	draw_text_transformed(x, y - 56, "[E] Entrar - " + string(custo) + " moedas", .6, .6, 0);
}

if(aviso > 0){
	draw_set_color(c_red);
	draw_text_transformed(x, y - 70, "Faltam " + string(custo - global.moedas) + " moedas!", .6, .6, 0);
}

draw_set_halign(fa_left);
draw_set_color(c_white);