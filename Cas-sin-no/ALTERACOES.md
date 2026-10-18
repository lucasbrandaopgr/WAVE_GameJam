# Alterações

## Bugs corrigidos
- **Moedas/almas zerando e porta não cobrando**: o `oGame` não era Persistent e rodava `game_reset()` a cada sala nova (moedas voltavam pra 10, almas pra 0). Agora ele é Persistent.
- **Soco**: área de acerto nova (retângulo na frente do jogador, 72 px + melhorias), acerta vários inimigos, destrói balas e mostra o arco do golpe. Em modo debug aparece um retângulo vermelho com a área real.
- **Inimigos sem moedas**: agora soltam moedas (que voam até você) e almas.
- **oEnemyPistola** estava com o pai errado (oEntidade); agora é filho de oEnemy (patrulha, leva dano e aparece nos golpes).
- **oPorta** agora mostra o preço e desconta as moedas de verdade.

## Mouse
Menu, opções, pause, tela de morte, loja do velho e minigames: passar o mouse seleciona, clicar confirma. O teclado continua funcionando.

## Novidades
- Menu de pause (ESC): continuar, salvar, volume, menu principal.
- Dash (SHIFT ou botão direito) com invulnerabilidade; soco no clique esquerdo; 3º soco seguido bate +50%.
- Minigames (tecla E perto da mesa): Blackjack, Poker (5 cartas), Caça-níquel, Dados.
- Inimigo novo: oEnemyPulador. Spawner de inimigos na Room2. Dano/almas/moedas escalam por andar.
- Room2 virou salão de cassino; a porta dela volta pra Room1 num andar mais difícil.
- Loja do velho com mais itens (alcance do soco, dash, ímã de moedas, trocar almas por moedas).
- Textos flutuantes (dano, +moedas, +almas) e HUD com andar e recarga do dash.

Lembrete: `global.debug` ainda está `true` no oGame (Create).
