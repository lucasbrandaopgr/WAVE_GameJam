if(global.pausado || instance_exists(oCassino)) exit;

if(jogador_perto(x, y - 24, 44, 44) && keyboard_check_pressed(ord("E"))){
	instance_create_depth(0, 0, -20000, oCassino, {jogo: jogo, nome: nome});
}
