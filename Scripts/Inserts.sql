-- ===========================================================
-- ************ Inserindo Dados Nas Tabelas ******************
-- ===========================================================


-- ============================================================
-- 1. TABELAS DE SUPORTE / DOMÍNIO
-- ============================================================

insert into tbl_escolaridade (nome) values
('Ensino Médio Completo'),
('Ensino Superior Incompleto'),
('Ensino Fundamental Completo');


insert into tbl_status (is_active) values
(true),
(false),
(true);

insert into tbl_nivel_acesso (nivel) values
('USUARIO'),
('ADMIN'),
('MODERADOR');


insert into tbl_level_user (nome, numero_level, xp_necessario) values
('Iniciante', 1, 0),
('Ambientalista', 2, 500),
('Guardião Verde', 3, 1000);


insert into tbl_instituicao (nome, descricao) values
('SENAI Jandira', 'Instituição de ensino profissionalizante.'),
('Faculdade de Tecnologia', 'Instituição de ensino superior.'),
('Escola Municipal Verde', 'Instituição de ensino básico.');


insert into tbl_categoria (nome) values
('Reciclagem'),
('Economia de Água'),
('Energia');


insert into tbl_dificuldade (nome) values
('Fácil'),
('Médio'),
('Difícil');


-- ============================================================
-- 2. USUÁRIOS
-- ============================================================

insert into tbl_usuario (
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
    id_level
) values
(
    'Lucas Kolle',
    'lucas@vibeeco.com',
    'senha_hash_123',
    'https://exemplo.com/fotos/lucas.jpg',
    350,
    120,
    '2026-10-06 08:30:00',
    1,
    1,
    1,
    1,
    1
),
(
    'Ana Silva',
    'ana@vibeeco.com',
    'senha_hash_456',
    'https://exemplo.com/fotos/ana.jpg',
    850,
    300,
    '2026-10-06 09:15:00',
    2,
    1,
    2,
    1,
    2
),
(
    'Pedro Souza',
    'pedro@vibeeco.com',
    'senha_hash_789',
    'https://exemplo.com/fotos/pedro.jpg',
    1200,
    450,
    '2026-10-06 10:00:00',
    3,
    1,
    3,
    1,
    3
);


insert into tbl_usuario_adm (
    email,
    senha,
    id_nivel_acesso
) values
(
    'admin@vibeeco.com',
    'senha_admin_123',
    2
),
(
    'gestor@vibeeco.com',
    'senha_gestor_456',
    2
),
(
    'moderador@vibeeco.com',
    'senha_moderador_789',
    3
);


-- ============================================================
-- 3. OFENSIVA
-- ============================================================

insert into tbl_ofensiva (
    id_usuario,
    data_ofensiva,
    concluido
) values
(
    1,
    '2026-10-06',
    true
),
(
    2,
    '2026-10-06',
    true
),
(
    3,
    '2026-10-06',
    false
);


-- ============================================================
-- 4. ANEXOS
-- ============================================================

insert into tbl_anexo (
    nome,
    endereco_url
) values
(
    'Imagem sobre reciclagem',
    'https://exemplo.com/anexos/reciclagem.jpg'
),
(
    'Imagem sobre economia de água',
    'https://exemplo.com/anexos/agua.jpg'
),
(
    'Imagem sobre energia limpa',
    'https://exemplo.com/anexos/energia.jpg'
);


-- ============================================================
-- 5. MISSÕES
-- ============================================================

insert into tbl_missao (
    nome,
    descricao,
    coins,
    total_xp_missao,
    data_inicio,
    data_termino,
    id_dificuldade
) values
(
    'Separe seu lixo',
    'Separe corretamente os materiais recicláveis do lixo comum.',
    50,
    100,
    '2026-11-01',
    '2026-11-30',
    1
),
(
    'Economize água',
    'Reduza o consumo de água durante suas atividades diárias.',
    100,
    200,
    '2026-10-01',
    '2026-10-31',
    2
),
(
    'Apague as luzes',
    'Desligue as luzes ao sair dos ambientes.',
    75,
    150,
    '2026-11-01',
    '2026-11-30',
    3
);


-- ============================================================
-- 6. DESAFIOS
-- ============================================================

insert into tbl_desafio (
    nome,
    descricao,
    super_coins,
    data_inicio,
    data_termino,
    id_dificuldade
) values
(
    'Desafio da Reciclagem',
    'Recicle materiais durante sete dias consecutivos.',
    150,
    '2026-10-01',
    '2026-10-31',
    1
),
(
    'Desafio da Água',
    'Economize água durante quinze dias.',
    300,
    '2026-10-01',
    '2026-10-31',
    2
),
(
    'Desafio da Energia',
    'Reduza o consumo de energia durante uma semana.',
    200,
    '2026-11-01',
    '2026-11-30',
    3
);


-- ============================================================
-- 7. CONTEÚDO EDUCATIVO
-- ============================================================

insert into tbl_conteudo_educativo (
    nome,
    descricao,
    img
) values
(
    'Como reciclar corretamente',
    'Aprenda como separar corretamente os materiais recicláveis.',
    'https://exemplo.com/img/reciclagem.jpg'
),
(
    'Como economizar água',
    'Confira dicas para reduzir o consumo de água em casa.',
    'https://exemplo.com/img/economia-agua.jpg'
),
(
    'Energia consciente',
    'Conheça formas de economizar energia no dia a dia.',
    'https://exemplo.com/img/energia.jpg'
);


-- ============================================================
-- 8. RECOMPENSAS
-- ============================================================

insert into tbl_recompensa (
    nome,
    descricao,
    valor,
    data_inicio,
    data_termino
) values
(
    'Caneca Sustentável',
    'Caneca reutilizável personalizada VibeEco.',
    500,
    '2026-10-01',
    '2026-12-31'
),
(
    'Ecobag VibeEco',
    'Sacola reutilizável para substituir sacolas plásticas.',
    800,
    '2026-10-01',
    '2026-12-31'
),
(
    'Garrafa Reutilizável',
    'Garrafa para reduzir o uso de copos descartáveis.',
    650,
    '2026-10-01',
    '2026-12-31'
);


-- ============================================================
-- 9. CONQUISTAS
-- ============================================================

insert into tbl_conquista (
    nome,
    descricao,
    img
) values
(
    'Primeira Missão',
    'Conclua sua primeira missão na plataforma.',
    'https://exemplo.com/conquistas/primeira-missao.jpg'
),
(
    'Eco Iniciante',
    'Acumule seus primeiros 500 pontos de experiência.',
    'https://exemplo.com/conquistas/eco-iniciante.jpg'
),
(
    'Protetor da Água',
    'Conclua uma atividade relacionada à economia de água.',
    'https://exemplo.com/conquistas/protetor-agua.jpg'
);


-- ============================================================
-- 10. MISSÃO + CATEGORIA
-- ============================================================

insert into tbl_missao_categoria (
    id_missao,
    id_categoria
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- ============================================================
-- 11. DESAFIO + CATEGORIA
-- ============================================================

insert into tbl_desafio_categoria (
    id_desafio,
    id_categoria
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- ============================================================
-- 12. CONTEÚDO EDUCATIVO + CATEGORIA
-- ============================================================

insert into tbl_conteudo_educativo_categoria (
    id_conteudo_educativo,
    id_categoria
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- ============================================================
-- 13. FEED / POSTS
-- ============================================================

insert into tbl_post (
    id_usuario,
    descricao,
    data_publicacao
) values
(
    1,
    'Hoje completei minha primeira missão sustentável!',
    now()
),
(
    2,
    'Comecei o desafio de economia de água.',
    now()
),
(
    3,
    'Estou aprendendo a economizar energia.',
    now()
);


-- ============================================================
-- 14. POST + ANEXO
-- ============================================================

insert into tbl_post_anexo (
    id_post,
    id_anexo
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


insert into tbl_post_categoria (
    id_post,
    id_categoria
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- ============================================================
-- 15. CURTIDAS
-- ============================================================

insert into tbl_post_curtida (
    id_usuario,
    id_post,
    data_curtida
) values
(
    2,
    1,
    now()
),
(
    3,
    2,
    now()
),
(
    1,
    3,
    now()
);


-- ============================================================
-- 16. COMENTÁRIOS
-- ============================================================

insert into tbl_post_comentario (
    id_usuario,
    id_post,
    comentario,
    data_comentario
) values
(
    2,
    1,
    'Muito legal! Também vou participar.',
    now()
),
(
    3,
    2,
    'Boa! Economizar água é muito importante.',
    now()
),
(
    1,
    3,
    'Ótima iniciativa! Vou fazer também.',
    now()
);


-- ============================================================
-- 17. PREMIAÇÃO
-- ============================================================

insert into tbl_premiacao (
    nome,
    descricao,
    codigo_rastreio,
    motivo_premiacao
) values
(
    'Kit Eco',
    'Kit sustentável entregue ao usuário.',
    'BR123456789',
    'Destaque mensal de sustentabilidade'
),
(
    'Kit Verde',
    'Kit com produtos reutilizáveis.',
    'BR987654321',
    'Maior pontuação da semana'
),
(
    'Kit Sustentável',
    'Conjunto de itens reutilizáveis.',
    'BR456789123',
    'Participação em ações ambientais'
);


-- ============================================================
-- 18. NOTIFICAÇÕES
-- ============================================================

insert into tbl_notificacao (
    id_usuario,
    titulo,
    mensagem,
    lida,
    data_criacao
) values
(
    1,
    'Missão concluída',
    'Parabéns! Você concluiu sua missão.',
    false,
    now()
),
(
    2,
    'Novo desafio disponível',
    'Um novo desafio de sustentabilidade está disponível.',
    false,
    now()
),
(
    3,
    'Nova conquista',
    'Você desbloqueou uma conquista.',
    false,
    now()
);


-- ============================================================
-- 19. USUÁRIO + MISSÃO
-- ============================================================

insert into tbl_usuario_missao (
    id_usuario,
    id_missao,
    status,
    data_conclusao
) values
(
    1,
    1,
    'CONCLUIDA',
    current_date()
),
(
    2,
    2,
    'EM_ANDAMENTO',
    null
),
(
    3,
    3,
    'EM_ANDAMENTO',
    null
);


-- ============================================================
-- 20. USUÁRIO + PREMIAÇÃO
-- ============================================================

insert into tbl_usuario_premiacao (
    id_usuario,
    id_premiacao
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- ============================================================
-- 21. USUÁRIO + DESAFIO
-- ============================================================

insert into tbl_usuario_desafio (
    id_usuario,
    id_desafio,
    status,
    data_conclusao
) values
(
    1,
    1,
    'CONCLUIDO',
    current_timestamp()
),
(
    2,
    2,
    'EM_ANDAMENTO',
    null
),
(
    3,
    3,
    'EM_ANDAMENTO',
    null
);


-- ============================================================
-- 22. USUÁRIO + RECOMPENSA
-- ============================================================

insert into tbl_usuario_recompensa (
    id_usuario,
    id_recompensa,
    data_resgate,
    codigo_resgate
) values
(
    1,
    1,
    '2026-10-06 16:00:00',
    'RESGATE001'
),
(
    2,
    2,
    '2026-10-06 16:30:00',
    'RESGATE002'
),
(
    3,
    3,
    '2026-10-06 17:00:00',
    'RESGATE003'
);


-- ============================================================
-- 23. USUÁRIO + CONTEÚDO EDUCATIVO
-- ============================================================

insert into tbl_usuario_conteudo_educativo (
    id_usuario,
    id_conteudo_educativo,
    concluido,
    data_acesso
) values
(
    1,
    1,
    true,
    '2026-10-06 17:00:00'
),
(
    2,
    2,
    false,
    '2026-10-06 17:30:00'
),
(
    3,
    3,
    true,
    '2026-10-06 18:00:00'
);


-- ============================================================
-- 24. USUÁRIO + CONQUISTA
-- ============================================================

insert into tbl_usuario_conquista (
    id_usuario,
    id_conquista,
    data_conquista
) values
(
    1,
    1,
    '2026-10-06 18:00:00'
),
(
    2,
    2,
    '2026-10-06 18:30:00'
),
(
    3,
    3,
    '2026-10-06 19:00:00'
);


-- ============================================================
-- 25. USUÁRIO + MISSÃO + CONTEÚDO + OFENSIVA
-- ============================================================

insert into tbl_usuario_missao_usuario_conteudo_educativo_ofensiva (
    id_usuario_missao,
    id_usuario_conteudo_educativo,
    id_ofensiva
) values
(
    1,
    1,
    1
),
(
    2,
    2,
    2
),
(
    3,
    3,
    3
);


-- ============================================================
-- 26. CONTEÚDO EDUCATIVO + ANEXO
-- ============================================================

insert into tbl_conteudo_educativo_anexo (
    id_conteudo_educativo,
    id_anexo
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- ============================================================
-- 27. RECOMPENSA + ANEXO
-- ============================================================

insert into tbl_recompensa_anexo (
    id_recompensa,
    id_anexo
) values
(
    1,
    1
),
(
    2,
    2
),
(
    3,
    3
);


-- 2) DIFICULDADES
insert into tbl_dificuldade (id, nome) values
    (1, 'Fácil'),
    (2, 'Médio'),
    (3, 'Difícil')
on duplicate key update nome = values(nome);


-- 3) CATEGORIAS
insert into tbl_categoria (id, nome) values
    (1, 'Reciclagem'),
    (2, 'Energia'),
    (3, 'Água')
on duplicate key update nome = values(nome);
