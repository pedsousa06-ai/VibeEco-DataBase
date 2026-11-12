USE db_vibeEco_2026;

-- ============================================================
-- TABELAS DE SUPORTE / DOMÍNIO
-- ============================================================

-- ESCOLARIDADE
INSERT INTO tbl_escolaridade (nome) VALUES
('Ensino Fundamental'),
('Ensino Médio');

-- STATUS
INSERT INTO tbl_status (is_active) VALUES
(TRUE),
(FALSE);

-- NÍVEL DE ACESSO
INSERT INTO tbl_nivel_acesso (nivel) VALUES
('Administrador'),
('Usuário');

-- LEVEL USER
INSERT INTO tbl_level_user (nome, numero_level, xp_necessario) VALUES
('Iniciante', 1, 0),
('Intermediário', 2, 500);

-- INSTITUIÇÃO
INSERT INTO tbl_instituicao (nome, descricao) VALUES
('Escola Estadual São Paulo', 'Instituição de ensino estadual.'),
('Colégio VibeEco', 'Instituição parceira da plataforma VibeEco.');

-- CATEGORIA
INSERT INTO tbl_categoria (nome) VALUES
('Reciclagem'),
('Sustentabilidade');

-- DIFICULDADE
INSERT INTO tbl_dificuldade (nome) VALUES
('Fácil'),
('Médio');


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
);

-- USUÁRIO ADMINISTRADOR
INSERT INTO tbl_usuario_adm (
    email,
    senha,
    id_nivel_acesso
) VALUES
(
    'admin1@vibeeco.com',
    'admin123',
    1
),
(
    'admin2@vibeeco.com',
    'admin456',
    1
);


-- ============================================================
-- OFENSIVA
-- ============================================================

-- OFENSIVA
INSERT INTO tbl_ofensiva (
    id_usuario,
    data_ofensiva,
    concluido
) VALUES
(
    1,
    '2026-11-09',
    TRUE
),
(
    2,
    '2026-11-09',
    FALSE
);


-- ============================================================
-- ANEXOS
-- ============================================================

-- ANEXO
INSERT INTO tbl_anexo (
    nome,
    endereco_url
) VALUES
(
    'Imagem de reciclagem',
    'https://vibeeco.com/anexos/reciclagem.png'
),
(
    'Imagem de sustentabilidade',
    'https://vibeeco.com/anexos/sustentabilidade.png'
);


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
    'Use recipientes diferentes para cada tipo de material.'
),
(
    'Economize água',
    'Pratique ações para reduzir o consumo de água.',
    100,
    200,
    '2026-11-01',
    '2026-11-30',
    2,
    'Anote o consumo da sua casa durante a semana para acompanhar sua evolução.'
);


-- ============================================================
-- MISSÃO ETAPA
-- ============================================================

INSERT INTO tbl_missao_etapa (
    id_missao,
    titulo,
    xp,
    ordem
) VALUES

-- MISSÃO 1: SEPARE SEU LIXO (100 XP)
(1, 'Identifique os materiais recicláveis da sua casa.', 20, 1),
(1, 'Separe papel e papelão corretamente.', 20, 2),
(1, 'Separe plásticos, vidros e metais.', 20, 3),
(1, 'Higienize os materiais recicláveis antes do descarte.', 20, 4),
(1, 'Descarte os materiais nos locais apropriados.', 20, 5),

-- MISSÃO 2: ECONOMIZE ÁGUA (200 XP)
(2, 'Identifique atividades que desperdiçam água no seu dia a dia.', 30, 1),
(2, 'Reduza o tempo durante o banho.', 40, 2),
(2, 'Feche a torneira enquanto escova os dentes.', 30, 3),
(2, 'Reutilize água sempre que possível.', 40, 4),
(2, 'Verifique possíveis vazamentos em sua residência.', 30, 5),
(2, 'Pratique e mantenha hábitos de consumo consciente.', 30, 6);

-- DESAFIO
INSERT INTO tbl_desafio (
    nome,
    descricao,
    super_coins,
    data_inicio,
    data_termino,
    id_dificuldade
) VALUES
(
    'Semana sem plástico',
    'Evite utilizar produtos descartáveis durante uma semana.',
    150,
    '2026-10-01',
    '2026-11-30',
    1
),
(
    'Plantando o futuro',
    'Plante uma árvore e registre sua atividade.',
    300,
    '2026-11-01',
    '2026-11-30',
    2
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
    4
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
(2, 2);

-- DESAFIO CATEGORIA
INSERT INTO tbl_desafio_categoria (
    id_desafio,
    id_categoria
) VALUES
(1, 1),
(2, 2);

-- CONTEÚDO EDUCATIVO CATEGORIA
INSERT INTO tbl_conteudo_educativo_categoria (
    id_conteudo_educativo,
    id_categoria
) VALUES
(1, 1),
(2, 2);


-- ============================================================
-- FEED E INTERAÇÕES SOCIAIS
-- ============================================================

-- POST
INSERT INTO tbl_post (
    id_usuario,
    descricao,
    data_publicacao
) VALUES
(
    1,
    'Hoje comecei a separar corretamente os materiais recicláveis!',
    '2026-11-09 10:00:00'
),
(
    2,
    'Estou participando do desafio Semana sem plástico!',
    '2026-11-09 11:30:00'
);

-- POST CATEGORIA
INSERT INTO tbl_post_categoria (
    id_post,
    id_categoria
) VALUES
(1, 1),
(2, 2);

-- POST ANEXO
INSERT INTO tbl_post_anexo (
    id_post,
    id_anexo
) VALUES
(1, 1),
(2, 2);

-- POST CURTIDA
INSERT INTO tbl_post_curtida (
    id_usuario,
    id_post
) VALUES
(1, 2),
(2, 1);

-- POST COMENTÁRIO
INSERT INTO tbl_post_comentario (
    id_usuario,
    id_post,
    comentario
) VALUES
(
    1,
    2,
    'Muito interessante esse desafio!'
),
(
    2,
    1,
    'Excelente iniciativa!'
);


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
(
    1,
    'Nova missão disponível',
    'Uma nova missão foi adicionada à plataforma!',
    FALSE
),
(
    2,
    'Desafio concluído',
    'Continue participando dos desafios sustentáveis!',
    TRUE
);


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
(
    1,
    1,
    'CONCLUIDA',
    '2026-11-09 15:00:00',
    100
),
(
    2,
    2,
    'EM_ANDAMENTO',
    NULL,
    50
);

-- USUÁRIO PREMIAÇÃO
INSERT INTO tbl_usuario_premiacao (
    id_usuario,
    id_premiacao
) VALUES
(1, 1),
(2, 2);

-- USUÁRIO DESAFIO
INSERT INTO tbl_usuario_desafio (
    id_usuario,
    id_desafio,
    status,
    data_conclusao
) VALUES
(
    1,
    1,
    'CONCLUIDO',
    '2026-11-07 18:00:00'
),
(
    2,
    2,
    'EM_ANDAMENTO',
    NULL
),
(
    1,
    2,
    'EM_ANDAMENTO',
    NULL
);

-- USUÁRIO RECOMPENSA
INSERT INTO tbl_usuario_recompensa (
    id_usuario,
    id_recompensa,
    codigo_resgate
) VALUES
(
    1,
    1,
    'RESGATE001'
),
(
    2,
    2,
    'RESGATE002'
);

-- USUÁRIO CONTEÚDO EDUCATIVO (inclui "tempo_acesso", criada via ALTER TABLE)
INSERT INTO tbl_usuario_conteudo_educativo (
    id_usuario,
    id_conteudo_educativo,
    concluido,
    tempo_acesso
) VALUES
(
    1,
    1,
    TRUE,
    300
),
(
    2,
    2,
    FALSE,
    120
);

-- USUÁRIO CONQUISTA
INSERT INTO tbl_usuario_conquista (
    id_usuario,
    id_conquista,
    data_conquista
) VALUES
(
    1,
    2,
    '2026-11-08 18:00:00'
),
(
    2,
    2,
    '2026-10-06 18:30:00'
),
(
    2,
    1,
    '2026-10-06 19:00:00'
);


-- ============================================================
-- OFENSIVA + MISSÃO + CONTEÚDO EDUCATIVO
-- ============================================================

-- USUÁRIO MISSÃO + USUÁRIO CONTEÚDO EDUCATIVO + OFENSIVA
INSERT INTO tbl_usuario_missao_usuario_conteudo_educativo_ofensiva (
    id_usuario_missao,
    id_usuario_conteudo_educativo,
    id_ofensiva
) VALUES
(
    1,
    1,
    1
),
(
    2,
    2,
    2
);


-- ============================================================
-- CONTEÚDO EDUCATIVO + ANEXO
-- ============================================================

-- CONTEÚDO EDUCATIVO ANEXO
INSERT INTO tbl_conteudo_educativo_anexo (
    id_conteudo_educativo,
    id_anexo
) VALUES
(1, 1),
(2, 2);


-- ============================================================
-- RECOMPENSA + ANEXO
-- ============================================================

-- RECOMPENSA ANEXO
INSERT INTO tbl_recompensa_anexo (
    id_recompensa,
    id_anexo
) VALUES
(1, 1),
(2, 2);


-- ============================================================
-- VERIFICAR TABELAS
-- ============================================================

SHOW TABLES;