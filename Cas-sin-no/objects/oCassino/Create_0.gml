//Janela de minigame. Criada pela mesa com {jogo: "...", nome: "..."}.
global.pausado = true;

if(!variable_instance_exists(id, "jogo")) jogo = "blackjack";

switch(jogo){
	case "poker":	g = undefined;	break;
	case "slot":	g = new JogoSlot();		break;
	case "dados":	g = new JogoDados();	break;
	default:		g = new JogoBlackjack();	break;
}
