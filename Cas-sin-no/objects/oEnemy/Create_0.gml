//Se a sala foi iniciada direto (debug), garante que o controlador do jogo existe
if(!instance_exists(oGame)) instance_create_depth(0, 0, 0, oGame);

// Inherit the parent event
//Tradução: Herdando evento do pai/Entidade
event_inherited();

//Personalizando as variáveis
vel		= 1;
dir		= 1;
hp		= 3;
stun	= 0;
parado	= false;	//Os filhos usam pra ficar parados (ex: atirando)
alma	= 1;		//Quantas almas solta ao morrer
dano	= 1;		//Dano de contato / dos tiros
moedas_min	= 1;	//Moedas que caem ao morrer (sorteia entre min e max)
moedas_max	= 2;
cor_base	= c_white;

levar_dano = function(_dano, _x_origem){
	hp		-= _dano;
	
	var _lado = sign(x - _x_origem);
	if(_lado == 0) _lado = 1;
	velh	= _lado * 4;	//Empurrão
	stun	= 15;
	
	popup(x, y - 40, "-" + string(round(_dano * 10) / 10), c_white);
	
	if(hp <= 0) morrer();
}

morrer = function(){
	//Solta moedas (pegue chegando perto) e ganha almas na hora
	var _qtd = irandom_range(moedas_min, moedas_max);
	repeat(_qtd){
		var _m = instance_create_depth(x, y - 16, -50, oMoeda);
		_m.velh = random_range(-2.5, 2.5);
		_m.velv = random_range(-6, -3);
	}
	
	global.almas += alma;
	popup(x, y - 54, "+" + string(alma) + ((alma == 1) ? " alma" : " almas"), c_aqua);
	
	instance_destroy();
}

//Cada andar completo deixa o inimigo mais forte e mais generoso
//(os filhos chamam isto no fim do Create deles)
escalar = function(){
	var _n = global.nivel;
	hp			+= _n;
	alma		+= _n div 3;
	dano		= 1 + (_n div 4);
	moedas_min	+= _n div 2;
	moedas_max	+= _n div 2;
}

//Anda pra frente; vira se bater na parede ou se acabar o chão
patrulhar = function(){
	var _parede	= place_meeting(x + dir * vel, y, oChao);
	var _px		= (dir > 0) ? bbox_right + 1 : bbox_left - 1;
	var _borda	= !position_meeting(_px, bbox_bottom + 1, oChao);
	
	if(_parede || _borda) dir *= -1;
	
	velh = dir * vel;
}

escalar();
