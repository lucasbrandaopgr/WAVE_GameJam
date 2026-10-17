alpha = min(alpha + .02, 1);
timer++;

//Espera um instante pra não pular a tela sem querer
if(timer > 60 && (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space))){
	room_goto(rVelho);
}

if(keyboard_check_pressed(vk_escape)) room_goto(rMenu);
