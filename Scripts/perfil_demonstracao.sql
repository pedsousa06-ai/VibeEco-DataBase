-- ============================================================================
--  VibeEco - PERFIL DE DEMONSTRAÇÃO (apresentação do TCC)
--
--  Cria uma usuária completa, com histórico de uso real do sistema:
--    - login pronto:      ana.beatriz@vibeeco.com   |  senha: Vibe@2026   (ou matrícula 2024001234)
--    - nível 2 (Intermediário), 795 XP, 270 moedas, ofensiva de 12 dias
--    - 3 missões concluídas, 2 em andamento (50% e 33%) e 1 disponível para participar
--    - 3 conteúdos lidos, 1 desafio concluído e 1 em andamento
--    - 3 publicações no feed com curtidas e comentários, conquistas, notificações e 1 recompensa resgatada
--
--  COMO USAR
--    1) Rode antes o banco base (Scripts/rodar_tudo.sql ou Creates.sql + Inserts.sql + Procedures).
--    2) Rode este arquivo inteiro. Ele pode ser executado de novo: apaga a demonstração anterior
--       e recria tudo do zero (não mexe nos outros usuários).
--
--  As datas são relativas a hoje (NOW/CURDATE), então o perfil sempre parece "recente".
--  O XP total (795) é exatamente a soma do XP das etapas e conteúdos concluídos abaixo.
-- ============================================================================

USE db_vibeEco_2026;

SET @email := 'ana.beatriz@vibeeco.com';
SET @uid   := (SELECT id FROM tbl_usuario WHERE email = @email);

-- ----------------------------------------------------------------------------
-- 0) LIMPEZA DA EXECUÇÃO ANTERIOR (só a demonstração)
-- ----------------------------------------------------------------------------
DELETE FROM tbl_post_curtida     WHERE id_usuario = @uid OR id_post IN (SELECT id FROM tbl_post WHERE id_usuario = @uid);
DELETE FROM tbl_post_comentario  WHERE id_usuario = @uid OR id_post IN (SELECT id FROM tbl_post WHERE id_usuario = @uid);
DELETE FROM tbl_post_categoria   WHERE id_post IN (SELECT id FROM tbl_post WHERE id_usuario = @uid);
DELETE FROM tbl_post_anexo       WHERE id_post IN (SELECT id FROM tbl_post WHERE id_usuario = @uid);
DELETE FROM tbl_post             WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_etapa    WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_missao   WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_desafio  WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_conteudo_educativo WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_conquista WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_recompensa WHERE id_usuario = @uid;
DELETE FROM tbl_usuario_grupo    WHERE id_usuario = @uid;
DELETE FROM tbl_notificacao      WHERE id_usuario = @uid;
DELETE FROM tbl_ofensiva         WHERE id_usuario = @uid;
DELETE FROM tbl_usuario          WHERE id = @uid;

-- missões criadas só para a demonstração
DELETE FROM tbl_missao_categoria WHERE id_missao IN (SELECT id FROM tbl_missao WHERE nome IN
    ('Semana do descarte consciente','Mutirão de reciclagem','Operação economia de água','Energia sob controle','Compostagem em casa'));
DELETE FROM tbl_missao_etapa     WHERE id_missao IN (SELECT id FROM tbl_missao WHERE nome IN
    ('Semana do descarte consciente','Mutirão de reciclagem','Operação economia de água','Energia sob controle','Compostagem em casa'));
DELETE FROM tbl_missao WHERE nome IN
    ('Semana do descarte consciente','Mutirão de reciclagem','Operação economia de água','Energia sob controle','Compostagem em casa');

-- ----------------------------------------------------------------------------
-- 1) USUÁRIA
--    senha = Vibe@2026 (guardada como hash scrypt, igual ao que o back-end grava)
-- ----------------------------------------------------------------------------
INSERT INTO tbl_usuario (
    nome, email, senha, foto, total_xp, coins, data_ultimo_acesso,
    id_escolaridade, id_status, id_instituicao, id_nivel_acesso, id_level,
    exibir_ranking, nome_publico, curso, localizacao, bio, matricula, data_cadastro
) VALUES (
    'Ana Beatriz Souza',
    'ana.beatriz@vibeeco.com',
    'scrypt$3a268a60d5a874298da91dc1046d9888$430d4ead8803959afe48d44d1cbd1106f916707ae72c02dd760353cd246816a2',
    'https://i.pravatar.cc/300?img=47',
    795,
    270,
    NOW(),
    (SELECT id FROM tbl_escolaridade WHERE nome = 'Ensino Superior'),
    (SELECT id FROM tbl_status WHERE is_active = TRUE ORDER BY id LIMIT 1),
    (SELECT id FROM tbl_instituicao WHERE nome = 'Colégio VibeEco'),
    (SELECT id FROM tbl_nivel_acesso WHERE nivel = 'Usuário'),
    (SELECT id FROM tbl_level_user WHERE numero_level = 2),
    TRUE,
    'Ana Bia',
    'Engenharia Ambiental',
    'Belo Horizonte, MG',
    'Apaixonada por reciclagem e vida sustentável. Um hábito verde por dia!',
    '2024001234',
    NOW() - INTERVAL 45 DAY
);
SET @uid := LAST_INSERT_ID();

-- grupo da instituição
INSERT INTO tbl_usuario_grupo (id_usuario, id_grupo, data_entrada)
SELECT @uid, g.id, NOW() - INTERVAL 40 DAY
  FROM tbl_grupo g
 WHERE g.id_instituicao = (SELECT id_instituicao FROM tbl_usuario WHERE id = @uid)
 ORDER BY g.id LIMIT 1;

-- ----------------------------------------------------------------------------
-- 2) OFENSIVA: 12 dias seguidos (hoje não conta se ainda não fez nada; aqui conta)
-- ----------------------------------------------------------------------------
INSERT INTO tbl_ofensiva (id_usuario, data_ofensiva, concluido)
SELECT @uid, CURDATE() - INTERVAL n DAY, TRUE
  FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
        UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11) dias;

-- ----------------------------------------------------------------------------
-- 3) MISSÕES (novas, com várias etapas) - prazo: de 25 dias atrás até daqui a 30 dias
-- ----------------------------------------------------------------------------
INSERT INTO tbl_missao (nome, descricao, coins, total_xp_missao, data_inicio, data_termino, id_dificuldade, dica) VALUES
('Semana do descarte consciente',
 'Aprenda a descartar cada tipo de resíduo no lugar certo durante uma semana.',
 80, 200, CURDATE() - INTERVAL 25 DAY, CURDATE() + INTERVAL 30 DAY,
 (SELECT id FROM tbl_dificuldade WHERE nome = 'Fácil'),
 'Cada cor de lixeira tem um destino: azul (papel), vermelha (plástico), verde (vidro), amarela (metal).'),
('Mutirão de reciclagem',
 'Organize a coleta seletiva da sua casa ou escola e leve os recicláveis ao ponto de entrega.',
 90, 200, CURDATE() - INTERVAL 25 DAY, CURDATE() + INTERVAL 30 DAY,
 (SELECT id FROM tbl_dificuldade WHERE nome = 'Médio'),
 'Lave as embalagens antes de separar: isso evita mau cheiro e facilita a reciclagem.'),
('Operação economia de água',
 'Reduza o consumo de água da sua rotina com pequenas mudanças de hábito.',
 120, 220, CURDATE() - INTERVAL 25 DAY, CURDATE() + INTERVAL 30 DAY,
 (SELECT id FROM tbl_dificuldade WHERE nome = 'Médio'),
 'Um banho de 5 minutos já economiza dezenas de litros por dia.'),
('Energia sob controle',
 'Descubra onde sua energia é desperdiçada e corte o consumo desnecessário.',
 150, 250, CURDATE() - INTERVAL 25 DAY, CURDATE() + INTERVAL 30 DAY,
 (SELECT id FROM tbl_dificuldade WHERE nome = 'Difícil'),
 'Aparelhos em stand-by continuam gastando energia: tire da tomada o que não usa.'),
('Compostagem em casa',
 'Transforme restos de comida em adubo e reduza o lixo orgânico.',
 100, 150, CURDATE() - INTERVAL 5 DAY, CURDATE() + INTERVAL 45 DAY,
 (SELECT id FROM tbl_dificuldade WHERE nome = 'Fácil'),
 'Restos de frutas, legumes e borra de café podem ir para a composteira.');

SET @m_descarte := (SELECT id FROM tbl_missao WHERE nome = 'Semana do descarte consciente');
SET @m_mutirao  := (SELECT id FROM tbl_missao WHERE nome = 'Mutirão de reciclagem');
SET @m_agua     := (SELECT id FROM tbl_missao WHERE nome = 'Operação economia de água');
SET @m_energia  := (SELECT id FROM tbl_missao WHERE nome = 'Energia sob controle');
SET @m_compost  := (SELECT id FROM tbl_missao WHERE nome = 'Compostagem em casa');
SET @m_lixo     := (SELECT id FROM tbl_missao WHERE nome = 'Separe seu lixo' LIMIT 1);

INSERT INTO tbl_missao_categoria (id_missao, id_categoria) VALUES
(@m_descarte, (SELECT id FROM tbl_categoria WHERE nome = 'Reciclagem')),
(@m_mutirao,  (SELECT id FROM tbl_categoria WHERE nome = 'Reciclagem')),
(@m_agua,     (SELECT id FROM tbl_categoria WHERE nome = 'Uso consciente da água')),
(@m_energia,  (SELECT id FROM tbl_categoria WHERE nome = 'Sustentabilidade')),
(@m_compost,  (SELECT id FROM tbl_categoria WHERE nome = 'Sustentabilidade'));

-- Etapas (a soma do XP das etapas de cada missão = total_xp_missao)
INSERT INTO tbl_missao_etapa (id_missao, titulo, xp, ordem) VALUES
(@m_descarte, 'Descubra o que vai em cada cor de lixeira.',                     40, 1),
(@m_descarte, 'Separe o lixo da sua casa por três dias seguidos.',              40, 2),
(@m_descarte, 'Ensine alguém da família a separar corretamente.',               60, 3),
(@m_descarte, 'Leve os recicláveis até um ponto de coleta.',                    60, 4),
(@m_mutirao,  'Monte um ponto de coleta seletiva em casa ou na escola.',        60, 1),
(@m_mutirao,  'Convide pelo menos três pessoas para participar.',               60, 2),
(@m_mutirao,  'Entregue os materiais em uma cooperativa ou ecoponto.',          80, 3),
(@m_agua,     'Meça quanto tempo dura o seu banho.',                            40, 1),
(@m_agua,     'Feche a torneira ao escovar os dentes e ensaboar a louça.',      50, 2),
(@m_agua,     'Reaproveite a água da máquina de lavar ou da chuva.',            60, 3),
(@m_agua,     'Verifique e conserte vazamentos em torneiras e descargas.',      70, 4),
(@m_energia,  'Faça um passeio pela casa anotando o que fica ligado sem uso.',  50, 1),
(@m_energia,  'Troque uma lâmpada comum por uma de LED.',                       80, 2),
(@m_energia,  'Passe uma semana desligando aparelhos da tomada.',              120, 3),
(@m_compost,  'Separe uma caixa para os restos orgânicos.',                     40, 1),
(@m_compost,  'Monte a composteira seguindo o passo a passo.',                  50, 2),
(@m_compost,  'Acompanhe a decomposição por duas semanas.',                     60, 3);

-- ----------------------------------------------------------------------------
-- 4) PARTICIPAÇÃO EM MISSÕES
--    progresso segue a regra da procedure procConcluirEtapa: FLOOR(concluídas*100/total)
-- ----------------------------------------------------------------------------
INSERT INTO tbl_usuario_missao (id_usuario, id_missao, status, progresso, data_conclusao) VALUES
(@uid, @m_lixo,     'CONCLUIDA',    100, NOW() - INTERVAL 20 DAY),
(@uid, @m_descarte, 'CONCLUIDA',    100, NOW() - INTERVAL 14 DAY),
(@uid, @m_mutirao,  'CONCLUIDA',    100, NOW() - INTERVAL 6 DAY),
(@uid, @m_agua,     'EM_ANDAMENTO',  50, NULL),
(@uid, @m_energia,  'EM_ANDAMENTO',  33, NULL);
-- "Compostagem em casa" fica sem participação: aparece como DISPONÍVEL no app.

-- Etapas concluídas (cada uma com a data em que foi feita)
INSERT INTO tbl_usuario_etapa (id_usuario, id_etapa, data_conclusao)
SELECT @uid, e.id, NOW() - INTERVAL 20 DAY FROM tbl_missao_etapa e WHERE e.id_missao = @m_lixo;

INSERT INTO tbl_usuario_etapa (id_usuario, id_etapa, data_conclusao)
SELECT @uid, e.id, NOW() - INTERVAL (20 - e.ordem * 2) DAY FROM tbl_missao_etapa e WHERE e.id_missao = @m_descarte;

INSERT INTO tbl_usuario_etapa (id_usuario, id_etapa, data_conclusao)
SELECT @uid, e.id, NOW() - INTERVAL (12 - e.ordem * 2) DAY FROM tbl_missao_etapa e WHERE e.id_missao = @m_mutirao;

INSERT INTO tbl_usuario_etapa (id_usuario, id_etapa, data_conclusao)
SELECT @uid, e.id, NOW() - INTERVAL (5 - e.ordem) DAY FROM tbl_missao_etapa e WHERE e.id_missao = @m_agua AND e.ordem <= 2;

INSERT INTO tbl_usuario_etapa (id_usuario, id_etapa, data_conclusao)
SELECT @uid, e.id, NOW() - INTERVAL 1 DAY FROM tbl_missao_etapa e WHERE e.id_missao = @m_energia AND e.ordem = 1;

-- ----------------------------------------------------------------------------
-- 5) CONTEÚDOS EDUCATIVOS LIDOS (XP: 50 + 75 + 100 = 225)
-- ----------------------------------------------------------------------------
INSERT INTO tbl_usuario_conteudo_educativo (id_usuario, id_conteudo_educativo, concluido, data_acesso, tempo_acesso)
SELECT @uid, c.id, TRUE, NOW() - INTERVAL (c.id + 3) DAY, c.duracao_leitura * 60
  FROM tbl_conteudo_educativo c
 WHERE c.nome IN ('A importância da reciclagem', 'Consumo consciente de água', 'Como economizar energia');

-- ----------------------------------------------------------------------------
-- 6) DESAFIOS
-- ----------------------------------------------------------------------------
INSERT INTO tbl_usuario_desafio (id_usuario, id_desafio, status, progresso, data_conclusao)
SELECT @uid, d.id, 'CONCLUIDO', 100, NOW() - INTERVAL 9 DAY FROM tbl_desafio d WHERE d.nome = 'Semana sem plástico';
INSERT INTO tbl_usuario_desafio (id_usuario, id_desafio, status, progresso, data_conclusao)
SELECT @uid, d.id, 'EM_ANDAMENTO', 40, NULL FROM tbl_desafio d WHERE d.nome = 'Plantando o futuro';

-- ----------------------------------------------------------------------------
-- 7) CONQUISTAS
-- ----------------------------------------------------------------------------
INSERT INTO tbl_usuario_conquista (id_usuario, id_conquista, data_conquista)
SELECT @uid, q.id, NOW() - INTERVAL
       CASE q.nome WHEN 'Primeiro passo' THEN 20 WHEN 'Amigo do planeta' THEN 10 ELSE 4 END DAY
  FROM tbl_conquista q
 WHERE q.nome IN ('Primeiro passo', 'Amigo do planeta', 'Consciência verde');

-- ----------------------------------------------------------------------------
-- 8) FEED: 3 publicações dela + curtidas e comentários de outros usuários
-- ----------------------------------------------------------------------------
INSERT INTO tbl_post (id_usuario, descricao, data_publicacao) VALUES
(@uid, 'Terminei o Mutirão de reciclagem! Juntamos mais de 30 kg de recicláveis com a turma e levamos tudo para o ecoponto. ♻️', NOW() - INTERVAL 6 DAY),
(@uid, 'Dica de hoje: meça o tempo do seu banho. Eu estava gastando 15 minutos e já cheguei em 6. Cada minuto conta! 💧', NOW() - INTERVAL 3 DAY),
(@uid, '12 dias de ofensiva no VibeEco! Quem mais está mantendo o ritmo? 🌱', NOW() - INTERVAL 4 HOUR);

SET @p1 := (SELECT id FROM tbl_post WHERE id_usuario = @uid ORDER BY data_publicacao ASC  LIMIT 1);
SET @p2 := (SELECT id FROM tbl_post WHERE id_usuario = @uid ORDER BY data_publicacao ASC  LIMIT 1 OFFSET 1);
SET @p3 := (SELECT id FROM tbl_post WHERE id_usuario = @uid ORDER BY data_publicacao DESC LIMIT 1);

INSERT INTO tbl_post_categoria (id_post, id_categoria) VALUES
(@p1, (SELECT id FROM tbl_categoria WHERE nome = 'Reciclagem')),
(@p2, (SELECT id FROM tbl_categoria WHERE nome = 'Uso consciente da água')),
(@p3, (SELECT id FROM tbl_categoria WHERE nome = 'Sustentabilidade'));

-- curtidas dos outros usuários nos posts dela
INSERT INTO tbl_post_curtida (id_usuario, id_post, data_curtida)
SELECT u.id, p.id, NOW() - INTERVAL 2 HOUR
  FROM tbl_usuario u
 CROSS JOIN (SELECT @p1 AS id UNION SELECT @p2 UNION SELECT @p3) p
 WHERE u.id <> @uid AND u.id_nivel_acesso = (SELECT id FROM tbl_nivel_acesso WHERE nivel = 'Usuário');

-- comentários
INSERT INTO tbl_post_comentario (id_usuario, id_post, comentario, data_comentario)
SELECT u.id, @p1, 'Que iniciativa incrível, Ana! Vou levar essa ideia para a minha turma.', NOW() - INTERVAL 5 DAY
  FROM tbl_usuario u WHERE u.email = 'mariana.santos@email.com';
INSERT INTO tbl_post_comentario (id_usuario, id_post, comentario, data_comentario)
SELECT u.id, @p2, 'Boa dica! Eu também reduzi o meu banho depois de cronometrar.', NOW() - INTERVAL 2 DAY
  FROM tbl_usuario u WHERE u.email = 'lucas.oliveira@email.com';
INSERT INTO tbl_post_comentario (id_usuario, id_post, comentario, data_comentario)
SELECT u.id, @p3, 'Parabéns pela ofensiva! Continue assim 👏', NOW() - INTERVAL 1 HOUR
  FROM tbl_usuario u WHERE u.email = 'pedro.almeida@email.com';

-- ela também curte e comenta posts dos outros
INSERT INTO tbl_post_curtida (id_usuario, id_post, data_curtida)
SELECT @uid, p.id, NOW() - INTERVAL 1 DAY FROM tbl_post p WHERE p.id_usuario <> @uid;
INSERT INTO tbl_post_comentario (id_usuario, id_post, comentario, data_comentario)
SELECT @uid, p.id, 'Adorei! Continue compartilhando seus hábitos sustentáveis.', NOW() - INTERVAL 1 DAY
  FROM tbl_post p WHERE p.id_usuario <> @uid ORDER BY p.id LIMIT 1;

-- ----------------------------------------------------------------------------
-- 9) RECOMPENSA RESGATADA (Caneca ecológica = 100 moedas)
--    moedas: 80 + 50 + 90 (missões) + 150 (desafio) - 100 (resgate) = 270
-- ----------------------------------------------------------------------------
INSERT INTO tbl_usuario_recompensa (id_usuario, id_recompensa, data_resgate, codigo_resgate)
SELECT @uid, r.id, NOW() - INTERVAL 2 DAY, 'VIBE-ANA-CNC-2026'
  FROM tbl_recompensa r WHERE r.nome = 'Caneca ecológica';

-- ----------------------------------------------------------------------------
-- 10) NOTIFICAÇÕES (3 não lidas)
-- ----------------------------------------------------------------------------
INSERT INTO tbl_notificacao (id_usuario, titulo, mensagem, lida, data_criacao) VALUES
(@uid, 'Missão concluída!',        'Parabéns! Você concluiu o Mutirão de reciclagem e ganhou 90 moedas.',          TRUE,  NOW() - INTERVAL 6 DAY),
(@uid, 'Nova conquista',           'Você desbloqueou a conquista "Consciência verde".',                           TRUE,  NOW() - INTERVAL 4 DAY),
(@uid, 'Recompensa resgatada',     'Sua Caneca ecológica foi resgatada. Código: VIBE-ANA-CNC-2026.',               TRUE,  NOW() - INTERVAL 2 DAY),
(@uid, 'Nova missão disponível',   'A missão "Compostagem em casa" já está disponível. Participe!',               FALSE, NOW() - INTERVAL 5 DAY),
(@uid, 'Sua ofensiva está ótima',  'Você está há 12 dias seguidos ativo no VibeEco. Não quebre a sequência!',      FALSE, NOW() - INTERVAL 3 HOUR),
(@uid, 'Ana, você subiu no ranking','Você está em 2º lugar no ranking geral. Continue assim!',                      FALSE, NOW() - INTERVAL 1 HOUR);

-- ----------------------------------------------------------------------------
-- 11) CONFERÊNCIA (mostra o resumo da usuária criada)
-- ----------------------------------------------------------------------------
SELECT u.id, u.nome, u.email, u.matricula, l.nome AS nivel, u.total_xp, u.coins,
       (SELECT COUNT(*) FROM tbl_usuario_missao  WHERE id_usuario = u.id AND status = 'CONCLUIDA')    AS missoes_concluidas,
       (SELECT COUNT(*) FROM tbl_usuario_missao  WHERE id_usuario = u.id AND status = 'EM_ANDAMENTO') AS missoes_andamento,
       (SELECT COUNT(*) FROM tbl_usuario_conteudo_educativo WHERE id_usuario = u.id AND concluido = TRUE) AS conteudos_lidos,
       (SELECT COUNT(*) FROM tbl_ofensiva        WHERE id_usuario = u.id AND concluido = TRUE)        AS dias_ofensiva,
       (SELECT COUNT(*) FROM tbl_post            WHERE id_usuario = u.id)                             AS posts
  FROM tbl_usuario u
  JOIN tbl_level_user l ON l.id = u.id_level
 WHERE u.id = @uid;
