//Fazendo a colizão horizontal
//Checando se estou colidindo com a parede
var _col	= instance_place(x + velh, y, oChao);

//Se eu colidi eu grudo em quem eu colidi
if(_col){
	//Checando se estou indo para a direita
	if(velh > 0){
		//Grudando na parte esquerda da parede
		x = _col.bbox_left + (x - bbox_right);
	}
	
	//Checando se estou indo para a esquerda
	if(velh < 0){
		//Grudando na parte direita da parede
		x = _col.bbox_right + (x - bbox_left);
	}
	
	//Quando colidir eu paro
	velh = 0;
}

x	+= velh;

_col	= instance_place(x, y + velv, oChao);
if(_col){
	if(velv > 0){
		//Indo pra baixo
		y = _col.bbox_top + (y - bbox_bottom);
	}
	if(velv < 0){
		//Indo pra cima
		y = _col.bbox_bottom + (y - bbox_top)
	}
	velv = 0;
}

y	+= velv;

//Virando o sprite pra onde a entidade olha
//(o origin dos sprites está no centro, então não trava na parede)
//Se a arte original olha pra ESQUERDA, troque por: image_xscale = -dir;
image_xscale = dir;
