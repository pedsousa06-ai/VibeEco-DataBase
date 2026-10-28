-- ======================================================================
-- MIGRAÇÃO: etapas, dica e participação única nas missões
-- Use este arquivo se o banco db_vibeEco_2026 JÁ FOI CRIADO.
-- (Para criar o banco do zero, use o Creates.sql, que já inclui tudo isto.)
-- Rode UMA vez: o "alter table ... add column" falha se a coluna já existir.
-- ======================================================================

use db_vibeEco_2026;

-- 1) Dica da missão
alter table tbl_missao
    add column dica text null after descricao;

-- 2) Etapas da missão (cadastradas no painel adm)
create table if not exists tbl_missao_etapa(
    id int not null primary key auto_increment,
    id_missao int not null,
    titulo varchar(150) not null,
    xp int not null,
    ordem int not null,

    constraint FK_MISSAO_MISSAOETAPA
        foreign key (id_missao)
        references tbl_missao(id),

    constraint UQ_MISSAO_ORDEM
        unique (id_missao, ordem)
);

-- 3) Etapas concluídas por cada usuário
create table if not exists tbl_usuario_missao_etapa(
    id int not null primary key auto_increment,
    id_usuario_missao int not null,
    id_missao_etapa int not null,
    data_conclusao datetime default current_timestamp,

    constraint FK_UME_USUARIOMISSAO
        foreign key (id_usuario_missao)
        references tbl_usuario_missao(id),

    constraint FK_UME_MISSAOETAPA
        foreign key (id_missao_etapa)
        references tbl_missao_etapa(id),

    constraint UQ_USUARIOMISSAO_ETAPA
        unique (id_usuario_missao, id_missao_etapa)
);

-- 4) Um usuário participa de uma missão uma única vez
--    (se der erro de "Duplicate entry", existem participações repetidas: apague-as antes)
alter table tbl_usuario_missao
    add constraint UQ_USUARIO_MISSAO unique (id_usuario, id_missao);

show tables;
desc tbl_missao;
