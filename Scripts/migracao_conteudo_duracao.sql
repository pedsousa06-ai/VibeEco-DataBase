-- ======================================================================
-- MIGRAÇÃO: tempo de leitura do conteúdo educativo
-- O formulário do painel tem o campo "Duração" (minutos de leitura), mas a tabela
-- tbl_conteudo_educativo não tinha onde guardá-lo.
-- Rode UMA vez: o "add column" falha se a coluna já existir.
-- (Se for recriar o banco do zero, inclua a coluna também no Creates.sql, dentro do
--  create table tbl_conteudo_educativo: duracao_leitura int not null default 5)
-- ======================================================================

use db_vibeEco_2026;

alter table tbl_conteudo_educativo
    add column duracao_leitura int not null default 5 after descricao;

-- conferir
desc tbl_conteudo_educativo;
select id, nome, duracao_leitura from tbl_conteudo_educativo;
