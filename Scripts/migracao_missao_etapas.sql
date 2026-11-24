-- ======================================================================
-- MIGRAÇÃO: etapas, dica e participação única nas missões
-- Use este arquivo se o banco db_vibeEco_2026 JÁ FOI CRIADO.
-- (Para criar o banco do zero, use o Creates.sql, que já inclui tudo isto.)
-- Rode UMA vez: o "alter table ... add column" falha se a coluna já existir.
-- ======================================================================

use db_vibeEco_2026;

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
