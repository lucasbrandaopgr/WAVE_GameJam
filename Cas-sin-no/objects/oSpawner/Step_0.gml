if(global.pausado) exit;

timer--;
if(timer > 0) exit;

timer = max(150, intervalo - global.nivel * 30);

//Não spawna em cima do player nem se a sala já está cheia
if(instance_number(oEnemy) >= maximo + global.nivel) exit;
if(instance_exists(oPlayer) && abs(oPlayer.x - x) < 220) exit;

var _r = irandom(99);
var _tipo = oEnemy;
if(_r >= 70) _tipo = oEnemyPulador;
else if(_r >= 40) _tipo = oEnemyPistola;

instance_create_depth(x, y, -10, _tipo);
