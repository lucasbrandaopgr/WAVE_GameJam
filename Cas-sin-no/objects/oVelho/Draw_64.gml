if(!aberto) exit;
draw_set_color(c_white);
draw_text(16, 80, "Almas: " + string(global.almas));
for(var i = 0; i < array_length(loja); i++){
	var _marca = (i == sel) ? "> " : "  ";
	draw_text(16, 110 + i * 20, _marca + loja[i].nome + " (" + string(loja[i].custo) + " almas)");
}