if (indice >= total) exit;

var gw = display_get_gui_width();
var gh = display_get_gui_height();

var nome  = linhas[indice][0];
var texto = string_copy(linhas[indice][1], 1, floor(chars_vis));

// Tela preta
draw_set_color(c_black);
draw_rectangle(0, 0, gw, gh, false);

// Fonte da cutscene (a mesma do menu)
draw_set_font(fMenu);
var escala = 1;                       // aumente (1.2, 1.5...) se o texto ficar pequeno
var altura = string_height("A") * escala;

// Cor do nome de quem está falando
var cor_nome = c_white;
if (nome == "NARRADOR") cor_nome = c_ltgray;
if (nome == "PROTA")    cor_nome = c_aqua;
if (nome == "VELHO")    cor_nome = c_orange;

// (Opcional) personagens na tela: quem fala fica brilhante, o outro escurecido
// Só descomente se você tiver spr_prota e spr_velho
// var a_prota = (nome == "PROTA") ? 1 : 0.3;
// var a_velho = (nome == "VELHO") ? 1 : 0.3;
// draw_sprite_ext(spr_prota, 0, gw * 0.25, gh * 0.45, 1, 1, 0, c_white, a_prota);
// draw_sprite_ext(spr_velho, 0, gw * 0.75, gh * 0.45, 1, 1, 0, c_white, a_velho);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Nome de quem fala
draw_set_color(cor_nome);
draw_text_transformed(80, gh - 220, nome, escala, escala, 0);

// Texto da fala (quebra de linha automática)
draw_set_color(c_white);
draw_text_ext_transformed(80, gh - 220 + altura * 1.5, texto, -1, (gw - 160) / escala, escala, escala, 0);

// Aviso piscando para apertar ESPAÇO (só quando a fala terminou de aparecer)
if (chars_vis >= string_length(linhas[indice][1]) && (current_time div 500) mod 2 == 0)
{
    draw_set_halign(fa_right);
    draw_text_transformed(gw - 60, gh - 50, "[ESPAÇO] continuar", escala, escala, 0);
    draw_set_halign(fa_left);
}

// Volta ao padrão para não afetar outros objetos
draw_set_font(-1);