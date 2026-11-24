-- ============================================================
-- INSERTS DE DADOS - BANCO DE DADOS VIBEECO
-- 3 registros por tabela
-- ============================================================

USE db_vibeEco_2026;

-- ============================================================
-- TABELAS DE SUPORTE / DOMÍNIO
-- ============================================================

-- ESCOLARIDADE
INSERT INTO tbl_escolaridade (nome) VALUES
('Ensino Fundamental'),
('Ensino Médio'),
('Ensino Superior');

-- STATUS
INSERT INTO tbl_status (is_active) VALUES
(TRUE),
(FALSE),
(TRUE);

-- NÍVEL DE ACESSO
INSERT INTO tbl_nivel_acesso (nivel) VALUES
('Administrador'),
('Usuário'),
('Moderador');

-- LEVEL USER
INSERT INTO tbl_level_user (nome, numero_level, xp_necessario) VALUES
('Iniciante', 1, 0),
('Intermediário', 2, 500),
('Avançado', 3, 1200);

-- INSTITUIÇÃO
INSERT INTO tbl_instituicao (nome, descricao) VALUES
('Escola Estadual São Paulo', 'Instituição de ensino estadual.'),
('Colégio VibeEco', 'Instituição parceira da plataforma VibeEco.'),
('Instituto Verde', 'Instituição voltada à educação e conscientização ambiental.');

-- CATEGORIA
INSERT INTO tbl_categoria (nome) VALUES
('Reciclagem'),
('Sustentabilidade'),
('Uso consciente da água');

-- DIFICULDADE
INSERT INTO tbl_dificuldade (nome) VALUES
('Fácil'),
('Médio'),
('Difícil');


-- ============================================================
-- USUÁRIO
-- ============================================================

-- USUÁRIO
INSERT INTO tbl_usuario (
    nome,
    email,
    senha,
    foto,
    total_xp,
    coins,
    data_ultimo_acesso,
    id_escolaridade,
    id_status,
    id_instituicao,
    id_nivel_acesso,
    id_level,
    exibir_ranking
) VALUES
(
    'Lucas Oliveira',
    'lucas.oliveira@email.com',
    'senha123',
    'https://vibeeco.com/fotos/lucas.png',
    350,
    100,
    '2026-11-10 08:00:00',
    1,
    1,
    1,
    2,
    1,
    TRUE
),
(
    'Mariana Santos',
    'mariana.santos@email.com',
    'senha456',
    'https://vibeeco.com/fotos/mariana.png',
    700,
    250,
    '2026-11-10 08:30:00',
    2,
    1,
    2,
    2,
    2,
    TRUE
),
(
    'Pedro Almeida',
    'pedro.almeida@email.com',
    'senha789',
    'https://vibeeco.com/fotos/pedro.png',
    1450,
    400,
    '2026-11-10 09:00:00',
    3,
    1,
    3,
    2,
    3,
    FALSE
);

-- USUÁRIO ADMINISTRADOR
INSERT INTO tbl_usuario_adm (
    email,
    senha,
    id_nivel_acesso
) VALUES
('admin1@vibeeco.com', 'admin123', 1),
('admin2@vibeeco.com', 'admin456', 1),
('moderador@vibeeco.com', 'moderador123', 3);


-- ============================================================
-- OFENSIVA
-- ============================================================

-- OFENSIVA
INSERT INTO tbl_ofensiva (
    id_usuario,
    data_ofensiva,
    concluido
) VALUES
(1, '2026-11-09', TRUE),
(2, '2026-11-09', FALSE),
(3, '2026-11-09', TRUE);


-- ============================================================
-- ANEXOS
-- ============================================================

-- ANEXO
INSERT INTO tbl_anexo (
    nome,
    endereco_url
) VALUES
('Imagem de reciclagem', 'https://vibeeco.com/anexos/reciclagem.png'),
('Imagem de sustentabilidade', 'https://vibeeco.com/anexos/sustentabilidade.png'),
('Imagem de economia de água', 'https://vibeeco.com/anexos/economia-agua.png');


-- ============================================================
-- MISSÕES, DESAFIOS E CONTEÚDOS
-- ============================================================

-- MISSÃO (inclui a coluna "dica", criada via ALTER TABLE)
INSERT INTO tbl_missao (
    nome,
    descricao,
    coins,
    total_xp_missao,
    data_inicio,
    data_termino,
    id_dificuldade,
    dica
) VALUES
(
    'Separe seu lixo',
    'Separe corretamente os materiais recicláveis.',
    50,
    100,
    '2026-11-01',
    '2026-11-30',
    1,
    'Verifique os símbolos nas embalagens para identificar os materiais.'
),
(
    'Economize água',
    'Pratique ações para reduzir o consumo de água.',
    100,
    200,
    '2026-11-01',
    '2026-11-30',
    2,
    'Comece reduzindo o tempo de banho e fechando a torneira.'
),
(
    'Reduza o consumo de energia',
    'Adote hábitos para diminuir o consumo de energia elétrica.',
    150,
    300,
    '2026-11-01',
    '2026-11-30',
    3,
    'Desligue aparelhos e luzes quando não estiverem em uso.'
);

-- MISSÃO ETAPA
INSERT INTO tbl_missao_etapa (
    id_missao,
    titulo,
    xp,
    ordem
) VALUES
(1, 'Identifique os materiais recicláveis da sua casa.', 30, 1),
(2, 'Feche a torneira enquanto escova os dentes.', 60, 1),
(3, 'Desligue as luzes ao sair dos ambientes.', 90, 1);

INSERT INTO tbl_tipo_desafio (nome) VALUES ('Individual'), ('Coletivo');

-- DESAFIO
INSERT INTO tbl_desafio (
    nome,
    descricao,
    super_coins,
    data_inicio,
    data_termino,
    id_dificuldade,
    id_tipo_desafio,
    meta_participantes
) VALUES
(
    'Semana sem plástico',
    'Evite utilizar produtos descartáveis durante uma semana.',
    150,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 30 DAY),
    1,
    1,
    100
),
(
    'Plantando o futuro',
    'Plante uma árvore e registre sua atividade.',
    300,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 30 DAY),
    2,
    2,
    100
),
(
    'Desafio energia consciente',
    'Passe uma semana reduzindo o consumo de energia elétrica.',
    450,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 30 DAY),
    3,
    1,
    200
);

-- CONTEÚDO EDUCATIVO (inclui "duracao_leitura", NOT NULL, criada via ALTER TABLE)
INSERT INTO tbl_conteudo_educativo (
    nome,
    descricao,
    img,
    qtde_xp,
    duracao_leitura
) VALUES
(
    'A importância da reciclagem',
    'Aprenda como a reciclagem contribui para o meio ambiente.',
    'https://vibeeco.com/conteudos/reciclagem.png',
    50,
    5
),
(
    'Consumo consciente de água',
    'Entenda a importância de economizar água.',
    'https://vibeeco.com/conteudos/agua.png',
    75,
    7
),
(
    'Como economizar energia',
    'Conheça atitudes simples para reduzir o consumo de energia.',
    'https://vibeeco.com/conteudos/energia.png',
    100,
    8
);

-- RECOMPENSA
INSERT INTO tbl_recompensa (
    nome,
    descricao,
    valor,
    data_inicio,
    data_termino
) VALUES
(
    'Caneca ecológica',
    'Caneca reutilizável produzida com material sustentável.',
    100,
    '2026-11-01',
    '2026-12-31'
),
(
    'Ecobag',
    'Sacola reutilizável para substituir sacolas plásticas.',
    200,
    '2026-11-01',
    '2026-12-31'
),
(
    'Kit sustentável',
    'Kit com itens reutilizáveis para o dia a dia.',
    300,
    '2026-11-01',
    '2026-12-31'
);

-- CONQUISTA
INSERT INTO tbl_conquista (
    nome,
    descricao,
    img
) VALUES
(
    'Primeiro passo',
    'Conclua sua primeira missão na plataforma.',
    'https://vibeeco.com/conquistas/primeiro-passo.png'
),
(
    'Amigo do planeta',
    'Conclua cinco atividades sustentáveis.',
    'https://vibeeco.com/conquistas/amigo-planeta.png'
),
(
    'Consciência verde',
    'Leia conteúdos educativos e pratique hábitos sustentáveis.',
    'https://vibeeco.com/conquistas/consciencia-verde.png'
);


-- ============================================================
-- RELACIONAMENTOS DE MISSÃO, DESAFIO E CONTEÚDO
-- ============================================================

-- MISSÃO CATEGORIA
INSERT INTO tbl_missao_categoria (
    id_missao,
    id_categoria
) VALUES
(1, 1),
(2, 3),
(3, 2);

-- DESAFIO CATEGORIA
INSERT INTO tbl_desafio_categoria (
    id_desafio,
    id_categoria
) VALUES
(1, 1),
(2, 2),
(3, 2);

-- CONTEÚDO EDUCATIVO CATEGORIA
INSERT INTO tbl_conteudo_educativo_categoria (
    id_conteudo_educativo,
    id_categoria
) VALUES
(1, 1),
(2, 3),
(3, 2);


-- ============================================================
-- FEED E INTERAÇÕES SOCIAIS
-- ============================================================

-- POST
INSERT INTO tbl_post (
    id_usuario,
    descricao,
    data_publicacao
) VALUES
(1, 'Hoje comecei a separar corretamente os materiais recicláveis!', '2026-11-09 10:00:00'),
(2, 'Estou participando do desafio Semana sem plástico!', '2026-11-09 11:30:00'),
(3, 'Adotei novos hábitos para economizar energia em casa.', '2026-11-09 14:00:00');

-- POST CATEGORIA
INSERT INTO tbl_post_categoria (
    id_post,
    id_categoria
) VALUES
(1, 1),
(2, 2),
(3, 2);

-- POST ANEXO
INSERT INTO tbl_post_anexo (
    id_post,
    id_anexo
) VALUES
(1, 1),
(2, 2),
(3, 3);

-- POST CURTIDA
INSERT INTO tbl_post_curtida (
    id_usuario,
    id_post
) VALUES
(1, 2),
(2, 1),
(3, 1);

-- POST COMENTÁRIO
INSERT INTO tbl_post_comentario (
    id_usuario,
    id_post,
    comentario
) VALUES
(1, 2, 'Muito interessante esse desafio!'),
(2, 1, 'Excelente iniciativa!'),
(3, 2, 'Também vou participar!');


-- ============================================================
-- PREMIAÇÃO
-- ============================================================

-- PREMIAÇÃO (nome limitado a varchar(20))
INSERT INTO tbl_premiacao (
    nome,
    descricao,
    codigo_rastreio,
    motivo_premiacao
) VALUES
(
    'Destaque do mês',
    'Premiação para o usuário com maior participação.',
    'RASTREIO001',
    'Participação ativa nas atividades.'
),
(
    'Aluno sustentável',
    'Reconhecimento por boas práticas ambientais.',
    'RASTREIO002',
    'Destaque em sustentabilidade.'
),
(
    'Agente verde',
    'Reconhecimento por incentivar ações ambientais.',
    'RASTREIO003',
    'Contribuição para a conscientização ambiental.'
);


-- ============================================================
-- NOTIFICAÇÕES
-- ============================================================

-- NOTIFICAÇÃO
INSERT INTO tbl_notificacao (
    id_usuario,
    titulo,
    mensagem,
    lida
) VALUES
(1, 'Nova missão disponível', 'Uma nova missão foi adicionada à plataforma!', FALSE),
(2, 'Desafio concluído', 'Continue participando dos desafios sustentáveis!', TRUE),
(3, 'Nova conquista', 'Você desbloqueou uma nova conquista!', FALSE);


-- ============================================================
-- TABELAS DE ASSOCIAÇÃO COM CONTROLE DE ESTADO
-- ============================================================

-- USUÁRIO MISSÃO
INSERT INTO tbl_usuario_missao (
    id_usuario,
    id_missao,
    status,
    data_conclusao,
    progresso
) VALUES
(1, 1, 'CONCLUIDA', '2026-11-09 15:00:00', 100),
(2, 2, 'EM_ANDAMENTO', NULL, 50),
(3, 3, 'EM_ANDAMENTO', NULL, 25);

-- USUÁRIO PREMIAÇÃO
INSERT INTO tbl_usuario_premiacao (
    id_usuario,
    id_premiacao
) VALUES
(1, 1),
(2, 2),
(3, 3);

-- USUÁRIO DESAFIO
INSERT INTO tbl_usuario_desafio (
    id_usuario,
    id_desafio,
    status,
    data_conclusao
) VALUES
(1, 1, 'CONCLUIDO', NOW()),
(2, 2, 'EM_ANDAMENTO', NULL),
(3, 3, 'EM_ANDAMENTO', NULL);

-- USUÁRIO RECOMPENSA
INSERT INTO tbl_usuario_recompensa (
    id_usuario,
    id_recompensa,
    codigo_resgate
) VALUES
(1, 1, 'RESGATE001'),
(2, 2, 'RESGATE002'),
(3, 3, 'RESGATE003');

-- USUÁRIO CONTEÚDO EDUCATIVO (inclui "tempo_acesso", criada via ALTER TABLE)
INSERT INTO tbl_usuario_conteudo_educativo (
    id_usuario,
    id_conteudo_educativo,
    concluido,
    tempo_acesso
) VALUES
(1, 1, TRUE, 300),
(2, 2, FALSE, 180),
(3, 3, TRUE, 480);

-- USUÁRIO CONQUISTA
INSERT INTO tbl_usuario_conquista (
    id_usuario,
    id_conquista,
    data_conquista
) VALUES
(1, 1, '2026-11-08 18:00:00'),
(2, 2, '2026-11-09 18:30:00'),
(3, 3, '2026-11-10 19:00:00');

-- USUÁRIO ETAPA
INSERT INTO tbl_usuario_etapa (
    id_usuario,
    id_etapa,
    data_conclusao
) VALUES
(1, 1, '2026-11-09 14:30:00'),
(2, 2, '2026-11-09 16:00:00'),
(3, 3, '2026-11-10 10:00:00');

-- ============================================================
-- OFENSIVA + MISSÃO + CONTEÚDO EDUCATIVO
-- ============================================================

-- USUÁRIO MISSÃO + USUÁRIO CONTEÚDO EDUCATIVO + OFENSIVA
INSERT INTO tbl_usuario_missao_usuario_conteudo_educativo_ofensiva (
    id_usuario_missao,
    id_usuario_conteudo_educativo,
    id_ofensiva
) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);


-- ============================================================
-- CONTEÚDO EDUCATIVO + ANEXO
-- ============================================================

-- CONTEÚDO EDUCATIVO ANEXO
INSERT INTO tbl_conteudo_educativo_anexo (
    id_conteudo_educativo,
    id_anexo
) VALUES
(1, 1),
(2, 2),
(3, 3);


-- ============================================================
-- RECOMPENSA + ANEXO
-- ============================================================

-- RECOMPENSA ANEXO
INSERT INTO tbl_recompensa_anexo (
    id_recompensa,
    id_anexo
) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO tbl_grupo (
    nome,
    descricao,
    id_instituicao
)
SELECT
    'Turma de Sustentabilidade',
    'Grupo de atividades sobre sustentabilidade',
    i.id
FROM tbl_instituicao i
WHERE i.nome = 'SENAI'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_grupo g
    WHERE g.nome = 'Turma de Sustentabilidade'
      AND g.id_instituicao = i.id
);


INSERT INTO tbl_grupo (
    nome,
    descricao,
    id_instituicao
)
SELECT
    'Turma de Reciclagem',
    'Grupo de atividades sobre reciclagem',
    i.id
FROM tbl_instituicao i
WHERE i.nome = 'SENAI'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_grupo g
    WHERE g.nome = 'Turma de Reciclagem'
      AND g.id_instituicao = i.id
);

SHOW TABLES LIKE 'tbl_anexo';
SHOW TABLES LIKE 'tbl_conteudo_educativo%';
SHOW TABLES LIKE 'tbl_usuario_conteudo_educativo';

INSERT INTO tbl_categoria (nome)
SELECT 'Reciclagem'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_categoria WHERE nome = 'Reciclagem'
);

INSERT INTO tbl_categoria (nome)
SELECT 'Sustentabilidade'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_categoria WHERE nome = 'Sustentabilidade'
);

INSERT INTO tbl_categoria (nome)
SELECT 'Meio Ambiente'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_categoria WHERE nome = 'Meio Ambiente'
);

INSERT INTO tbl_categoria (nome)
SELECT 'Economia de Água'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_categoria WHERE nome = 'Economia de Água'
);

INSERT INTO tbl_categoria (nome)
SELECT 'Energia'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_categoria WHERE nome = 'Energia'
);

-- =====================================================
-- 2. ANEXOS
-- =====================================================

INSERT INTO tbl_anexo (nome, endereco_url)
SELECT 'Guia de Reciclagem', '/uploads/anexos/guia-reciclagem.pdf'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_anexo WHERE nome = 'Guia de Reciclagem'
);

INSERT INTO tbl_anexo (nome, endereco_url)
SELECT 'Manual de Sustentabilidade', '/uploads/anexos/manual-sustentabilidade.pdf'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_anexo WHERE nome = 'Manual de Sustentabilidade'
);

INSERT INTO tbl_anexo (nome, endereco_url)
SELECT 'Guia de Economia de Água', '/uploads/anexos/economia-agua.pdf'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_anexo WHERE nome = 'Guia de Economia de Água'
);

INSERT INTO tbl_anexo (nome, endereco_url)
SELECT 'Cartilha de Energia Limpa', '/uploads/anexos/energia-limpa.pdf'
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_anexo WHERE nome = 'Cartilha de Energia Limpa'
);

-- =====================================================
-- 3. CONTEÚDOS EDUCATIVOS
-- =====================================================

INSERT INTO tbl_conteudo_educativo
(nome, descricao, img, qtde_xp, duracao_leitura)
SELECT
'Como separar o lixo corretamente',
'Aprenda a separar os resíduos recicláveis e orgânicos e entenda a importância da coleta seletiva.',
'/uploads/conteudos/reciclagem.jpg',
20,
5
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_conteudo_educativo
    WHERE nome = 'Como separar o lixo corretamente'
);

INSERT INTO tbl_conteudo_educativo
(nome, descricao, img, qtde_xp, duracao_leitura)
SELECT
'A importância da sustentabilidade',
'Conheça práticas sustentáveis que ajudam a preservar os recursos naturais e reduzir os impactos ambientais.',
'/uploads/conteudos/sustentabilidade.jpg',
30,
8
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_conteudo_educativo
    WHERE nome = 'A importância da sustentabilidade'
);

INSERT INTO tbl_conteudo_educativo
(nome, descricao, img, qtde_xp, duracao_leitura)
SELECT
'Preservação do meio ambiente',
'Entenda como pequenas atitudes podem contribuir para a proteção da natureza e da biodiversidade.',
'/uploads/conteudos/meio-ambiente.jpg',
25,
6
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_conteudo_educativo
    WHERE nome = 'Preservação do meio ambiente'
);

INSERT INTO tbl_conteudo_educativo
(nome, descricao, img, qtde_xp, duracao_leitura)
SELECT
'Como economizar água',
'Descubra maneiras de evitar o desperdício de água em casa, na escola e em outros ambientes.',
'/uploads/conteudos/economia-agua.jpg',
20,
5
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_conteudo_educativo
    WHERE nome = 'Como economizar água'
);

INSERT INTO tbl_conteudo_educativo
(nome, descricao, img, qtde_xp, duracao_leitura)
SELECT
'Energia renovável e limpa',
'Aprenda sobre fontes renováveis de energia e como elas ajudam a reduzir os impactos ambientais.',
'/uploads/conteudos/energia-limpa.jpg',
35,
10
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_conteudo_educativo
    WHERE nome = 'Energia renovável e limpa'
);

-- =====================================================
-- 4. RELACIONAR CONTEÚDOS COM CATEGORIAS
-- =====================================================

INSERT INTO tbl_conteudo_educativo_categoria
(id_conteudo_educativo, id_categoria)
SELECT ce.id, c.id
FROM tbl_conteudo_educativo ce
JOIN tbl_categoria c ON c.nome = 'Reciclagem'
WHERE ce.nome = 'Como separar o lixo corretamente'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_categoria rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_categoria = c.id
);

INSERT INTO tbl_conteudo_educativo_categoria
(id_conteudo_educativo, id_categoria)
SELECT ce.id, c.id
FROM tbl_conteudo_educativo ce
JOIN tbl_categoria c ON c.nome = 'Sustentabilidade'
WHERE ce.nome = 'A importância da sustentabilidade'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_categoria rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_categoria = c.id
);

INSERT INTO tbl_conteudo_educativo_categoria
(id_conteudo_educativo, id_categoria)
SELECT ce.id, c.id
FROM tbl_conteudo_educativo ce
JOIN tbl_categoria c ON c.nome = 'Meio Ambiente'
WHERE ce.nome = 'Preservação do meio ambiente'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_categoria rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_categoria = c.id
);

INSERT INTO tbl_conteudo_educativo_categoria
(id_conteudo_educativo, id_categoria)
SELECT ce.id, c.id
FROM tbl_conteudo_educativo ce
JOIN tbl_categoria c ON c.nome = 'Economia de Água'
WHERE ce.nome = 'Como economizar água'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_categoria rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_categoria = c.id
);

INSERT INTO tbl_conteudo_educativo_categoria
(id_conteudo_educativo, id_categoria)
SELECT ce.id, c.id
FROM tbl_conteudo_educativo ce
JOIN tbl_categoria c ON c.nome = 'Energia'
WHERE ce.nome = 'Energia renovável e limpa'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_categoria rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_categoria = c.id
);

-- =====================================================
-- 5. RELACIONAR CONTEÚDOS COM ANEXOS
-- =====================================================

INSERT INTO tbl_conteudo_educativo_anexo
(id_conteudo_educativo, id_anexo)
SELECT ce.id, a.id
FROM tbl_conteudo_educativo ce
JOIN tbl_anexo a ON a.nome = 'Guia de Reciclagem'
WHERE ce.nome = 'Como separar o lixo corretamente'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_anexo rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_anexo = a.id
);

INSERT INTO tbl_conteudo_educativo_anexo
(id_conteudo_educativo, id_anexo)
SELECT ce.id, a.id
FROM tbl_conteudo_educativo ce
JOIN tbl_anexo a ON a.nome = 'Manual de Sustentabilidade'
WHERE ce.nome = 'A importância da sustentabilidade'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_anexo rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_anexo = a.id
);

INSERT INTO tbl_conteudo_educativo_anexo
(id_conteudo_educativo, id_anexo)
SELECT ce.id, a.id
FROM tbl_conteudo_educativo ce
JOIN tbl_anexo a ON a.nome = 'Guia de Economia de Água'
WHERE ce.nome = 'Como economizar água'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_anexo rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_anexo = a.id
);

INSERT INTO tbl_conteudo_educativo_anexo
(id_conteudo_educativo, id_anexo)
SELECT ce.id, a.id
FROM tbl_conteudo_educativo ce
JOIN tbl_anexo a ON a.nome = 'Cartilha de Energia Limpa'
WHERE ce.nome = 'Energia renovável e limpa'
AND NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_anexo rel
    WHERE rel.id_conteudo_educativo = ce.id
    AND rel.id_anexo = a.id
);

INSERT INTO tbl_grupo (
    nome,
    descricao,
    id_instituicao,
    ativo
)
VALUES (
    'Grupo Verde',
    'Grupo de estudantes do projeto VibeEco.',
    1,
    1
);

INSERT INTO tbl_usuario_grupo (
    id_usuario,
    id_grupo
)
SELECT
    1,
    id
FROM tbl_grupo
WHERE nome = 'Grupo Verde'
  AND id_instituicao = 1;

INSERT INTO tbl_usuario_grupo (
    id_usuario,
    id_grupo
)
VALUES (2, 1);

COMMIT;
-- =====================================================
-- FIM
-- =====================================================
