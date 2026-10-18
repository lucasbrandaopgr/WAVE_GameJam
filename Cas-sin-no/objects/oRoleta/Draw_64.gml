if(estado == 0) exit;

var _gw		= display_get_gui_width();
var _gh		= display_get_gui_height();
var _cx		= _gw / 2;
var _cy		= _gh / 2 - 20;
var _r		= min(_gw, _gh) * .36;
var _passo	= 360 / n_fatias;

//Fundo escurecido
draw_set_alpha(.75);
draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(1);

//Fatias
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

for(var i = 0; i < n_fatias; i++){
	var _a0		= ang + i * _passo;
	var _cor	= fatias[i].cor;
	
	draw_primitive_begin(pr_trianglefan);
	draw_vertex_color(_cx, _cy, _cor, 1);
	for(var s = 0; s <= 8; s++){
		var _a = _a0 + s * (_passo / 8);
		draw_vertex_color(_cx + lengthdir_x(_r, _a), _cy + lengthdir_y(_r, _a), _cor, 1);
	}
	draw_primitive_end();
	
	//Divisória
	draw_set_color(c_black);
	draw_line_width(_cx, _cy, _cx + lengthdir_x(_r, _a0), _cy + lengthdir_y(_r, _a0), 3);
	
	//Nome da fatia (gira junto)
	var _ac = _a0 + _passo / 2;
	draw_text_transformed(_cx + lengthdir_x(_r * .35, _ac), _cy + lengthdir_y(_r * .35, _ac), fatias[i].nome, 1, 1, _ac);
}

//Contorno e centro
draw_set_color(c_white);
draw_circle(_cx, _cy, _r, true);
draw_set_color(c_black);
draw_circle(_cx, _cy, 12, false);

//Ponteiro (em cima)
draw_set_color(c_white);
draw_triangle(_cx - 14, _cy - _r - 24, _cx + 14, _cy - _r - 24, _cx, _cy - _r + 6, false);

//Resultado
draw_set_halign(fa_center);
if(estado == 1){
	draw_text_transformed(_cx, _cy + _r + 40, "Girando...", 1.5, 1.5, 0);
}else{
	draw_set_color(c_yellow);
	draw_text_transformed(_cx, _cy + _r + 40, fatias[resultado].nome + " - " + fatias[resultado].desc, 1.5, 1.5, 0);
}

//Volta o estado padrão do desenho
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
