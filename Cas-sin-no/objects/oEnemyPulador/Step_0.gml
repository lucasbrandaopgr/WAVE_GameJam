//Gravidade, patrulha, dano de contato e piscar vermelho (do pai)
event_inherited();

if(global.pausado) exit;

var _chao = place_meeting(x, y + 1, oChao);

if(_chao){
	if(pulo_cd > 0) pulo_cd--;
	
	//Viu o player perto? Pula em cima dele
	if(stun <= 0 && pulo_cd <= 0 && instance_exists(oPlayer)
	&& abs(oPlayer.x - x) < 240 && abs(oPlayer.y - y) < 90){
		dir			= (oPlayer.x >= x) ? 1 : -1;
		velv		= -7;
		salto_vx	= dir * 2.6;
		velh		= salto_vx;
		pulo_cd		= 80;
	}
}else if(stun <= 0){
	//No ar: mantém o impulso do pulo
	velh = salto_vx;
}
