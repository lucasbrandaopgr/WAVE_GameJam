// Cada linha: [quem fala, o que fala]
linhas = [
    ["NARRADOR", "Estamos em um cassino luxuoso em Las White River, onde um cidadão frequente no CA-SIN-NO aposta com um velho misterioso e emburrado, porém algo inesperado acontece."],
    ["VELHO",    "Vamos apostar, meu jovem."],
    ["PROTA",    "Uma ultima vez não faz mal."],
    ["VELHO",    "HA HA HA! Perdeu de novo!"],
    ["PROTA",    "Não acredito nisso... VAMOS MAIS UMA!"],
    ["NARRADOR", "Eles jogam de novo"],
    ["VELHO",    "HA HA HA! DESISTA!"],
    ["PROTA",    "Eu... EU PERDI TUDO!"],
    ["VELHO",    "O QUE?!! GUARDAS, SEGUREM ELE!!!"]
];

indice = 0;                       // qual fala está aparecendo
total = array_length(linhas);     // quantas falas existem
chars_vis = 0;                    // letras já reveladas (efeito de digitação)
velocidade = 0.6;                 // letras por frame (aumente para ficar mais rápido)