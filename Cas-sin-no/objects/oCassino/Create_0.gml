//Janela de minigame. Criada pela mesa com {jogo: "...", nome: "..."}.
global.pausado = true;

if(!variable_instance_exists(id, "jogo")) jogo = "blackjack";

switch(jogo){
	case "poker":	g = new JogoPoker();	break;
	case "slot":	g = new JogoSlot();		break;
	case "dados":	g = new JogoDados();	break;
	default:		g = new JogoBlackjack();	break;
}

//Proteção: se algum jogo não puder ser criado, fecha a janela e libera o jogo
if(is_undefined(g)){
	modal_fechou();
	instance_destroy();
	exit;
}
