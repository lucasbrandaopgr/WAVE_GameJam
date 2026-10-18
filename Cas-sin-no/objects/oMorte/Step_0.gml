alpha = min(alpha + .02, 1);
timer++;

//=== Mouse e teclado ===
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _clique	= mouse_check_button_pressed(mb_left);
var _ok		= keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

if(timer > 60){
	var _b0 = rect_botao(0);
	var _b1 = rect_botao(1);
	
	if(_clique && ui_sobre(_b0.x, _b0.y, _b0.w, _b0.h)) _ok = true;
	if(_clique && ui_sobre(_b1.x, _b1.y, _b1.w, _b1.h)){
		room_goto(rMenu);
		exit;
	}
	
	//Espera um instante pra não pular a tela sem querer
	if(_ok) room_goto(rVelho);
}

if(keyboard_check_pressed(vk_escape)) room_goto(rMenu);
