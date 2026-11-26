USE db_vibeEco_2026;

START TRANSACTION;

-- =====================================================
-- 1. CATEGORIAS
-- =====================================================

INSERT INTO tbl_categoria (nome)
SELECT x.nome
FROM (
    SELECT 'Reciclagem' AS nome
    UNION ALL SELECT 'Sustentabilidade'
    UNION ALL SELECT 'Meio Ambiente'
    UNION ALL SELECT 'Água'
    UNION ALL SELECT 'Energia'
    UNION ALL SELECT 'Biodiversidade'
    UNION ALL SELECT 'Consumo Consciente'
    UNION ALL SELECT 'Educação Ambiental'
) x
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_categoria c WHERE c.nome = x.nome
);

-- =====================================================
-- 2. DIFICULDADES
-- =====================================================

INSERT INTO tbl_dificuldade (nome)
SELECT x.nome
FROM (
    SELECT 'Fácil' AS nome
    UNION ALL SELECT 'Médio'
    UNION ALL SELECT 'Difícil'
) x
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_dificuldade d WHERE d.nome = x.nome
);

-- =====================================================
-- 3. TIPOS DE DESAFIO
-- =====================================================

INSERT INTO tbl_tipo_desafio (nome)
SELECT x.nome
FROM (
    SELECT 'Individual' AS nome
    UNION ALL SELECT 'Coletivo'
) x
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_tipo_desafio t WHERE t.nome = x.nome
);

-- =====================================================
-- 4. CADASTRO DOS 10 PERFIS
-- =====================================================

INSERT INTO tbl_usuario (
    nome, email, senha, foto, total_xp, coins,
    data_ultimo_acesso, id_escolaridade, id_status,
    id_instituicao, id_nivel_acesso, id_level,
    exibir_ranking, nome_publico, curso, localizacao,
    bio, matricula, idioma, tema, alto_contraste,
    tamanho_fonte, animacoes, atividades_visiveis,
    perfil_publico
)
SELECT
    p.nome,
    p.email,
    p.senha,
    p.foto,
    p.xp,
    p.coins,
    NOW(),
    (SELECT id FROM tbl_escolaridade ORDER BY id LIMIT 1),
    (SELECT id FROM tbl_status WHERE is_active = TRUE ORDER BY id LIMIT 1),
    COALESCE(
        (SELECT id FROM tbl_instituicao WHERE nome = 'SENAI' ORDER BY id LIMIT 1),
        (SELECT id FROM tbl_instituicao ORDER BY id LIMIT 1)
    ),
    COALESCE(
        (SELECT id FROM tbl_nivel_acesso WHERE nivel = 'Usuário' ORDER BY id LIMIT 1),
        (SELECT id FROM tbl_nivel_acesso ORDER BY id LIMIT 1)
    ),
    COALESCE(
        (SELECT id FROM tbl_level_user WHERE xp_necessario <= p.xp ORDER BY xp_necessario DESC LIMIT 1),
        (SELECT id FROM tbl_level_user ORDER BY xp_necessario LIMIT 1)
    ),
    TRUE,
    p.nome_publico,
    p.curso,
    p.localizacao,
    p.bio,
    p.matricula,
    'pt-BR',
    'claro',
    FALSE,
    'medio',
    TRUE,
    TRUE,
    TRUE
FROM (
    SELECT 'Gabriel Oliveira' AS nome, 'gabriel.ranking@vibeeco.com' AS email,
    'ranking_sem_login' AS senha, 'https://i.pravatar.cc/150?img=12' AS foto,
    12000 AS xp, 1500 AS coins, 'Gabriel' AS nome_publico,
    'Meio Ambiente' AS curso, 'São Paulo' AS localizacao,
    'Sempre buscando novas atitudes sustentáveis.' AS bio, 'RANK001' AS matricula

    UNION ALL SELECT 'Ana Beatriz', 'ana.beatriz@vibeeco.com',
    'Vibe@2026', 'https://i.pravatar.cc/150?img=47',
    11000, 1300, 'Ana Beatriz', 'Desenvolvimento de Sistemas',
    'Jandira - SP', 'Apaixonada por sustentabilidade e tecnologia.', 'VIBE2026'

    UNION ALL SELECT 'Mariana Santos', 'mariana.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=44',
    9500, 1100, 'Mariana', 'Meio Ambiente', 'São Paulo',
    'Pequenas atitudes fazem a diferença.', 'RANK003'

    UNION ALL SELECT 'Lucas Oliveira', 'lucas.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=11',
    8500, 1000, 'Lucas', 'Administração', 'Osasco - SP',
    'Comprometido com um futuro mais verde.', 'RANK004'

    UNION ALL SELECT 'Isabela Costa', 'isabela.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=45',
    7500, 900, 'Isabela', 'Meio Ambiente', 'Barueri - SP',
    'Acredito na transformação ambiental.', 'RANK005'

    UNION ALL SELECT 'Rafael Mendes', 'rafael.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=13',
    6500, 800, 'Rafael', 'Logística', 'Jandira - SP',
    'Aprendendo e praticando sustentabilidade.', 'RANK006'

    UNION ALL SELECT 'Beatriz Almeida', 'beatriz.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=49',
    5500, 700, 'Beatriz', 'Desenvolvimento de Sistemas', 'São Paulo',
    'Cuidar do planeta é responsabilidade de todos.', 'RANK007'

    UNION ALL SELECT 'Matheus Ferreira', 'matheus.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=14',
    4500, 600, 'Matheus', 'Administração', 'Carapicuíba - SP',
    'Buscando hábitos melhores todos os dias.', 'RANK008'

    UNION ALL SELECT 'Julia Rodrigues', 'julia.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=48',
    3500, 500, 'Julia', 'Meio Ambiente', 'Barueri - SP',
    'A sustentabilidade começa nas nossas escolhas.', 'RANK009'

    UNION ALL SELECT 'Pedro Henrique', 'pedro.ranking@vibeeco.com',
    'ranking_sem_login', 'https://i.pravatar.cc/150?img=15',
    2500, 400, 'Pedro', 'Desenvolvimento de Sistemas', 'Osasco - SP',
    'Um passo de cada vez por um mundo melhor.', 'RANK010'
) p
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_usuario u WHERE u.email = p.email
);

-- =====================================================
-- 5. CONTEÚDOS EDUCATIVOS
-- =====================================================

INSERT INTO tbl_conteudo_educativo
(nome, descricao, img, qtde_xp, duracao_leitura)
SELECT x.nome, x.descricao, x.img, x.xp, x.duracao
FROM (
    SELECT
    'A importância das florestas' AS nome,
    'As florestas são essenciais para o equilíbrio ambiental. Elas absorvem gás carbônico, produzem oxigênio, regulam o clima e abrigam milhares de espécies. Preservar as florestas é proteger a biodiversidade e garantir recursos naturais para as próximas gerações.' AS descricao,
    '/uploads/conteudos/florestas.jpg' AS img, 50 AS xp, 5 AS duracao

    UNION ALL SELECT
    'O caminho do lixo',
    'O descarte correto dos resíduos é fundamental para evitar a poluição. A separação entre materiais recicláveis, orgânicos e rejeitos facilita a coleta seletiva e reduz a quantidade de lixo enviada aos aterros.',
    '/uploads/conteudos/caminho-do-lixo.jpg', 40, 4

    UNION ALL SELECT
    'Biodiversidade brasileira',
    'O Brasil possui uma das maiores biodiversidades do planeta. Seus biomas abrigam espécies únicas de animais e plantas que precisam de proteção contra o desmatamento, a poluição e a exploração irregular.',
    '/uploads/conteudos/biodiversidade.jpg', 60, 6

    UNION ALL SELECT
    'Energia solar no cotidiano',
    'A energia solar utiliza a luz do sol para gerar eletricidade e aquecer água. É uma alternativa renovável que pode reduzir a dependência de fontes poluentes e contribuir para uma matriz energética mais sustentável.',
    '/uploads/conteudos/energia-solar.jpg', 45, 5

    UNION ALL SELECT
    'Compostagem e adubo natural',
    'A compostagem transforma resíduos orgânicos em adubo natural. Cascas de frutas, restos de verduras e folhas secas podem ser reaproveitados para enriquecer o solo e diminuir o volume de resíduos.',
    '/uploads/conteudos/compostagem.jpg', 50, 5

    UNION ALL SELECT
    'Consumo consciente de plástico',
    'Reduzir o consumo de plástico descartável ajuda a diminuir a poluição dos rios e oceanos. Priorizar produtos reutilizáveis e separar embalagens para reciclagem são atitudes importantes.',
    '/uploads/conteudos/plastico.jpg', 40, 4

    UNION ALL SELECT
    'Economia de água em casa',
    'Pequenas mudanças de hábito ajudam a economizar água. Fechar a torneira ao escovar os dentes, consertar vazamentos e reutilizar água sempre que possível são atitudes que fazem diferença.',
    '/uploads/conteudos/economia-agua.jpg', 35, 4

    UNION ALL SELECT
    'Mobilidade urbana sustentável',
    'Caminhar, utilizar bicicletas e optar pelo transporte coletivo são alternativas que podem reduzir a emissão de poluentes e melhorar a qualidade de vida nas cidades.',
    '/uploads/conteudos/mobilidade.jpg', 45, 5
) x
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_conteudo_educativo c WHERE c.nome = x.nome
);

-- =====================================================
-- 6. RELACIONAR CONTEÚDOS E CATEGORIAS
-- =====================================================

INSERT INTO tbl_conteudo_educativo_categoria
(id_conteudo_educativo, id_categoria)
SELECT c.id, cat.id
FROM (
    SELECT 'A importância das florestas' AS conteudo, 'Biodiversidade' AS categoria
    UNION ALL SELECT 'O caminho do lixo', 'Reciclagem'
    UNION ALL SELECT 'Biodiversidade brasileira', 'Meio Ambiente'
    UNION ALL SELECT 'Energia solar no cotidiano', 'Energia'
    UNION ALL SELECT 'Compostagem e adubo natural', 'Reciclagem'
    UNION ALL SELECT 'Consumo consciente de plástico', 'Consumo Consciente'
    UNION ALL SELECT 'Economia de água em casa', 'Água'
    UNION ALL SELECT 'Mobilidade urbana sustentável', 'Sustentabilidade'
) x
JOIN tbl_conteudo_educativo c ON c.nome = x.conteudo
JOIN tbl_categoria cat ON cat.nome = x.categoria
WHERE NOT EXISTS (
    SELECT 1
    FROM tbl_conteudo_educativo_categoria rel
    WHERE rel.id_conteudo_educativo = c.id
      AND rel.id_categoria = cat.id
);

-- =====================================================
-- 7. MISSÕES
-- =====================================================

INSERT INTO tbl_missao
(nome, descricao, coins, total_xp_missao, data_inicio, data_termino, id_dificuldade, dica)
SELECT
    x.nome,
    x.descricao,
    x.coins,
    x.xp,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 30 DAY),
    d.id,
    x.dica
FROM (
    SELECT 'Desafio do lixo zero' AS nome,
    'Reduza a produção de resíduos durante sua rotina e pratique o descarte correto.' AS descricao,
    100 AS coins, 200 AS xp, 'Fácil' AS dificuldade,
    'Separe os resíduos e evite produtos descartáveis.' AS dica

    UNION ALL SELECT 'Horta sustentável',
    'Monte ou cuide de uma pequena horta e aprenda sobre cultivo sustentável.',
    150, 300, 'Médio',
    'Utilize compostagem para enriquecer o solo.'

    UNION ALL SELECT 'Consumo consciente',
    'Adote hábitos de consumo responsáveis e evite desperdícios.',
    120, 250, 'Médio',
    'Antes de comprar, avalie se o produto é realmente necessário.'

    UNION ALL SELECT 'Protetores da biodiversidade',
    'Conheça e divulgue ações que ajudam a proteger a fauna e a flora.',
    180, 350, 'Difícil',
    'Pesquise espécies ameaçadas e formas de preservação.'

    UNION ALL SELECT 'Semana da mobilidade verde',
    'Experimente alternativas sustentáveis de deslocamento.',
    100, 200, 'Fácil',
    'Priorize caminhadas, bicicletas e transporte coletivo.'
) x
JOIN tbl_dificuldade d ON d.nome = x.dificuldade
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_missao m WHERE m.nome = x.nome
);

-- =====================================================
-- 8. CATEGORIAS DAS MISSÕES
-- =====================================================

INSERT INTO tbl_missao_categoria (id_missao, id_categoria)
SELECT m.id, c.id
FROM (
    SELECT 'Desafio do lixo zero' AS missao, 'Reciclagem' AS categoria
    UNION ALL SELECT 'Horta sustentável', 'Sustentabilidade'
    UNION ALL SELECT 'Consumo consciente', 'Consumo Consciente'
    UNION ALL SELECT 'Protetores da biodiversidade', 'Biodiversidade'
    UNION ALL SELECT 'Semana da mobilidade verde', 'Meio Ambiente'
) x
JOIN tbl_missao m ON m.nome = x.missao
JOIN tbl_categoria c ON c.nome = x.categoria
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_missao_categoria mc
    WHERE mc.id_missao = m.id AND mc.id_categoria = c.id
);

-- =====================================================
-- 9. ETAPAS DAS MISSÕES
-- =====================================================

INSERT INTO tbl_missao_etapa (id_missao, titulo, xp, ordem)
SELECT m.id, x.titulo, x.xp, x.ordem
FROM (
    SELECT 'Desafio do lixo zero' AS missao, 'Identificar os resíduos produzidos em casa' AS titulo, 40 AS xp, 1 AS ordem
    UNION ALL SELECT 'Desafio do lixo zero', 'Separar materiais recicláveis', 50, 2
    UNION ALL SELECT 'Desafio do lixo zero', 'Reduzir o uso de descartáveis', 50, 3
    UNION ALL SELECT 'Desafio do lixo zero', 'Descartar os resíduos corretamente', 60, 4

    UNION ALL SELECT 'Horta sustentável', 'Escolher o local da horta', 50, 1
    UNION ALL SELECT 'Horta sustentável', 'Preparar o solo', 70, 2
    UNION ALL SELECT 'Horta sustentável', 'Plantar sementes ou mudas', 80, 3
    UNION ALL SELECT 'Horta sustentável', 'Cuidar das plantas', 100, 4

    UNION ALL SELECT 'Consumo consciente', 'Analisar hábitos de consumo', 50, 1
    UNION ALL SELECT 'Consumo consciente', 'Evitar compras desnecessárias', 60, 2
    UNION ALL SELECT 'Consumo consciente', 'Priorizar produtos reutilizáveis', 60, 3
    UNION ALL SELECT 'Consumo consciente', 'Compartilhar boas práticas', 80, 4

    UNION ALL SELECT 'Protetores da biodiversidade', 'Pesquisar espécies locais', 70, 1
    UNION ALL SELECT 'Protetores da biodiversidade', 'Identificar ameaças ambientais', 80, 2
    UNION ALL SELECT 'Protetores da biodiversidade', 'Conhecer ações de preservação', 100, 3
    UNION ALL SELECT 'Protetores da biodiversidade', 'Divulgar a importância da proteção', 100, 4

    UNION ALL SELECT 'Semana da mobilidade verde', 'Planejar um trajeto sustentável', 40, 1
    UNION ALL SELECT 'Semana da mobilidade verde', 'Utilizar transporte coletivo', 50, 2
    UNION ALL SELECT 'Semana da mobilidade verde', 'Experimentar caminhar ou pedalar', 50, 3
    UNION ALL SELECT 'Semana da mobilidade verde', 'Avaliar os benefícios da mudança', 60, 4
) x
JOIN tbl_missao m ON m.nome = x.missao
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_missao_etapa e
    WHERE e.id_missao = m.id AND e.ordem = x.ordem
);

-- =====================================================
-- 10. DESAFIOS
-- =====================================================

INSERT INTO tbl_desafio
(nome, descricao, super_coins, data_inicio, data_termino,
 id_dificuldade, id_tipo_desafio, meta_participantes)
SELECT
    x.nome,
    x.descricao,
    x.coins,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL x.dias DAY),
    d.id,
    t.id,
    x.meta
FROM (
    SELECT 'Cidade mais limpa' AS nome,
    'Participe de ações para manter os espaços públicos limpos e preservar o meio ambiente.' AS descricao,
    250 AS coins, 30 AS dias, 'Médio' AS dificuldade,
    'Coletivo' AS tipo, 30 AS meta

    UNION ALL SELECT '30 dias de sustentabilidade',
    'Pratique uma atitude sustentável todos os dias durante um mês.',
    300, 30, 'Difícil', 'Individual', 1

    UNION ALL SELECT 'Plantio coletivo',
    'Mobilize pessoas para plantar e cuidar de mudas em sua comunidade.',
    400, 45, 'Médio', 'Coletivo', 50
) x
JOIN tbl_dificuldade d ON d.nome = x.dificuldade
JOIN tbl_tipo_desafio t ON t.nome = x.tipo
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_desafio des WHERE des.nome = x.nome
);

-- =====================================================
-- 11. CATEGORIAS DOS DESAFIOS
-- =====================================================

INSERT INTO tbl_desafio_categoria (id_desafio, id_categoria)
SELECT d.id, c.id
FROM (
    SELECT 'Cidade mais limpa' AS desafio, 'Meio Ambiente' AS categoria
    UNION ALL SELECT '30 dias de sustentabilidade', 'Sustentabilidade'
    UNION ALL SELECT 'Plantio coletivo', 'Biodiversidade'
) x
JOIN tbl_desafio d ON d.nome = x.desafio
JOIN tbl_categoria c ON c.nome = x.categoria
WHERE NOT EXISTS (
    SELECT 1 FROM tbl_desafio_categoria dc
    WHERE dc.id_desafio = d.id AND dc.id_categoria = c.id
);

COMMIT;

-- =====================================================
-- 12. CONFERÊNCIA DOS CADASTROS
-- =====================================================

SELECT
    id, nome, email, total_xp, coins, exibir_ranking
FROM tbl_usuario
WHERE email LIKE '%@vibeeco.com'
ORDER BY total_xp DESC;

SELECT id, nome, qtde_xp, duracao_leitura
FROM tbl_conteudo_educativo
ORDER BY id;

SELECT id, nome, coins, total_xp_missao
FROM tbl_missao
ORDER BY id;

SELECT
    m.nome AS missao,
    e.ordem,
    e.titulo,
    e.xp
FROM tbl_missao_etapa e
JOIN tbl_missao m ON m.id = e.id_missao
ORDER BY m.id, e.ordem;

SELECT id, nome, super_coins, meta_participantes
FROM tbl_desafio
ORDER BY id;
