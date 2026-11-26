-- ============================================================
-- Conteúdos educativos extras (com imagens) - VibeEco
-- Idempotente: pode ser rodado várias vezes.
-- As imagens vêm de loremflickr.com (fotos por palavra-chave, ?lock fixa a foto).
-- Para trocar por fotos próprias, basta dar UPDATE na coluna img.
-- ============================================================

-- Imagens dos 3 conteúdos originais (as URLs vibeeco.com não existem)
UPDATE tbl_conteudo_educativo SET img = 'https://loremflickr.com/800/500/recycling,paper?lock=1' WHERE nome = 'A importância da reciclagem';
UPDATE tbl_conteudo_educativo SET img = 'https://loremflickr.com/800/500/water,river?lock=2' WHERE nome = 'Consumo consciente de água';
UPDATE tbl_conteudo_educativo SET img = 'https://loremflickr.com/800/500/lightbulb,energy?lock=3' WHERE nome = 'Como economizar energia';

-- Os 5 Rs da sustentabilidade
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Os 5 Rs da sustentabilidade', 'Recusar, reduzir, reutilizar, reciclar e repensar: entenda a ordem certa das ações.\n\nA reciclagem é só uma das etapas. Antes dela vêm recusar o que não precisamos, reduzir o consumo e reutilizar o que já temos. Cada R evita resíduo na origem, o que é mais eficiente do que tratar o lixo depois.\n\nNo dia a dia: leve sua sacola, recuse canudos e embalagens desnecessárias, conserte antes de substituir e doe o que não usa mais. Por fim, repense hábitos: pergunte-se se realmente precisa daquele item.', 'https://loremflickr.com/800/500/nature,forest?lock=10', 70, 6 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Os 5 Rs da sustentabilidade');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Sustentabilidade'
WHERE c.nome = 'Os 5 Rs da sustentabilidade'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Como separar o lixo corretamente
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Como separar o lixo corretamente', 'Guia prático das cores da coleta seletiva e o que vai em cada lixeira.\n\nAzul: papel e papelão. Vermelho: plástico. Verde: vidro. Amarelo: metal. Preto: madeira. Laranja: resíduos perigosos. Marrom: orgânicos. Cinza: não reciclável ou misturado.\n\nLave levemente as embalagens, retire restos de comida e amasse garrafas para ocupar menos espaço. Resíduo sujo pode contaminar todo um lote de material reciclável.', 'https://loremflickr.com/800/500/recycling,bins?lock=11', 60, 5 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Como separar o lixo corretamente');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Reciclagem'
WHERE c.nome = 'Como separar o lixo corretamente'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Compostagem: transforme restos em adubo
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Compostagem: transforme restos em adubo', 'Aprenda a fazer compostagem doméstica com poucos materiais.\n\nCerca de metade do lixo doméstico é orgânico. Em vez de ir ao aterro e gerar gás metano, ele pode virar adubo rico em nutrientes.\n\nUse três caixas: uma de húmus, duas de minhocas e restos. Misture sobras de frutas e legumes (matéria úmida) com folhas secas e serragem (matéria seca). Evite carne, laticínios e frituras. Em cerca de dois meses você terá composto para suas plantas.', 'https://loremflickr.com/800/500/compost,garden?lock=12', 90, 8 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Compostagem: transforme restos em adubo');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Sustentabilidade'
WHERE c.nome = 'Compostagem: transforme restos em adubo'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Plástico nos oceanos: o tamanho do problema
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Plástico nos oceanos: o tamanho do problema', 'Como o plástico chega ao mar e o que podemos fazer para reduzir esse impacto.\n\nMilhões de toneladas de plástico chegam aos oceanos todos os anos, vindas principalmente de rios e de descarte inadequado em áreas urbanas. Com o tempo, o plástico se fragmenta em microplásticos, ingeridos por animais marinhos.\n\nReduzir descartáveis, preferir produtos reutilizáveis e participar de mutirões de limpeza são ações simples e eficazes.', 'https://loremflickr.com/800/500/ocean,plastic?lock=13', 80, 7 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Plástico nos oceanos: o tamanho do problema');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Reciclagem'
WHERE c.nome = 'Plástico nos oceanos: o tamanho do problema'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Energia solar para iniciantes
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Energia solar para iniciantes', 'Entenda como funciona a energia solar e por que ela cresce no Brasil.\n\nOs painéis fotovoltaicos convertem luz do sol em eletricidade, sem emitir gases durante a operação. O excedente pode ser injetado na rede e gerar créditos na conta de luz.\n\nMesmo sem painéis, você pode contribuir: aproveite a luz natural, troque lâmpadas por LED e desligue aparelhos da tomada quando não estiverem em uso.', 'https://loremflickr.com/800/500/solar,panel?lock=14', 100, 8 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Energia solar para iniciantes');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Sustentabilidade'
WHERE c.nome = 'Energia solar para iniciantes'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Água: 10 dicas para economizar em casa
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Água: 10 dicas para economizar em casa', 'Pequenos hábitos que reduzem muito o consumo de água.\n\nUm banho de 15 minutos pode gastar mais de 100 litros. Reduzi-lo para 5 minutos já faz grande diferença. Feche a torneira ao escovar os dentes e ao ensaboar a louça.\n\nConserte vazamentos: uma torneira pingando desperdiça centenas de litros por mês. Reaproveite a água da chuva e da máquina de lavar para limpar quintais e calçadas.', 'https://loremflickr.com/800/500/water,tap?lock=15', 65, 5 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Água: 10 dicas para economizar em casa');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Uso consciente da água'
WHERE c.nome = 'Água: 10 dicas para economizar em casa'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Moda sustentável e consumo consciente
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Moda sustentável e consumo consciente', 'O impacto da indústria têxtil e como vestir-se de forma mais responsável.\n\nA produção de roupas consome muita água e gera grande quantidade de resíduos. A chamada fast fashion estimula o descarte rápido de peças.\n\nPrefira qualidade a quantidade, frequente brechós, troque roupas com amigos e dê nova vida a peças antigas com customização.', 'https://loremflickr.com/800/500/clothes,thrift?lock=16', 55, 6 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Moda sustentável e consumo consciente');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Sustentabilidade'
WHERE c.nome = 'Moda sustentável e consumo consciente'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Mobilidade verde: pedalar, caminhar e compartilhar
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Mobilidade verde: pedalar, caminhar e compartilhar', 'Como escolher transportes que poluem menos e melhoram a sua saúde.\n\nO transporte é uma das maiores fontes de emissão de CO2 nas cidades. Trocar o carro por bicicleta, transporte coletivo ou caronas em trajetos curtos reduz poluição e trânsito.\n\nAlém de ecológico, pedalar e caminhar melhoram a saúde e o humor. Planeje rotas e combine modais.', 'https://loremflickr.com/800/500/bicycle,city?lock=17', 75, 6 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Mobilidade verde: pedalar, caminhar e compartilhar');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Sustentabilidade'
WHERE c.nome = 'Mobilidade verde: pedalar, caminhar e compartilhar'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

-- Lixo eletrônico: para onde vai o seu celular velho?
INSERT INTO tbl_conteudo_educativo (nome, descricao, img, qtde_xp, duracao_leitura)
SELECT 'Lixo eletrônico: para onde vai o seu celular velho?', 'Descubra por que o lixo eletrônico exige cuidado especial e onde descartá-lo.\n\nCelulares, pilhas e baterias contêm metais pesados como chumbo e mercúrio, que contaminam solo e água se descartados no lixo comum. Também possuem materiais valiosos que podem ser recuperados.\n\nProcure pontos de coleta em lojas, supermercados e prefeituras, e considere consertar ou doar aparelhos funcionais.', 'https://loremflickr.com/800/500/electronics,waste?lock=18', 85, 7 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo WHERE nome = 'Lixo eletrônico: para onde vai o seu celular velho?');
INSERT INTO tbl_conteudo_educativo_categoria (id_conteudo_educativo, id_categoria)
SELECT c.id, g.id FROM tbl_conteudo_educativo c JOIN tbl_categoria g ON g.nome = 'Reciclagem'
WHERE c.nome = 'Lixo eletrônico: para onde vai o seu celular velho?'
  AND NOT EXISTS (SELECT 1 FROM tbl_conteudo_educativo_categoria x WHERE x.id_conteudo_educativo = c.id AND x.id_categoria = g.id);

SELECT id, nome, qtde_xp, duracao_leitura, img FROM tbl_conteudo_educativo ORDER BY id;
