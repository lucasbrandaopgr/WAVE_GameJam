if (indice >= total) exit;

var texto_completo = linhas[indice][1];

if (chars_vis < string_length(texto_completo))
{
    // Texto ainda "digitando"
    chars_vis += velocidade;

    // ESPAÇO durante a digitação mostra a fala inteira de uma vez
    if (keyboard_check_pressed(vk_space)) chars_vis = string_length(texto_completo);
}
else if (keyboard_check_pressed(vk_space))
{
    // Fala completa e jogador apertou ESPAÇO: próxima fala
    indice++;
    chars_vis = 0;

    // Acabaram as falas: vai para o gameplay
    if (indice >= total) room_goto(Room1);
}