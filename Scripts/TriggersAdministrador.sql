-- =====================================================================
-- triggers de exclusão - banco de dados db_vibeeco_2026
--
-- objetivo:
--   centralizar a remoção dos registros dependentes antes da exclusão
--   de uma missão vinculada ao usuário ou de um usuário.
--
-- observação:
--   as exclusões são feitas explicitamente pelas triggers. não é
--   necessário configurar on delete cascade nas relações tratadas aqui.
-- =====================================================================

use db_vibeeco_2026;

delimiter $$

-- ---------------------------------------------------------------------
-- 1. exclusão dos vínculos de uma missão do usuário
--
-- quando um registro de tbl_usuario_missao for excluído, remove primeiro
-- os vínculos correspondentes na tabela intermediária. isso evita a
-- violação da fk_usuariomissao_usuariomissao_ofensiva.
-- ---------------------------------------------------------------------

drop trigger if exists trg_before_delete_usuario_missao$$

create trigger trg_before_delete_usuario_missao
before delete on tbl_usuario_missao
for each row
begin
    delete from tbl_usuario_missao_usuario_conteudo_educativo_ofensiva
    where id_usuario_missao = old.id;
end$$


-- ---------------------------------------------------------------------
-- 2. exclusão dos dados relacionados ao usuário
--
-- remove os registros dependentes antes da exclusão em tbl_usuario:
--   - comentários e curtidas feitos pelo usuário;
--   - notificações recebidas pelo usuário;
--   - vínculos entre missões e ofensivas do usuário;
--   - ofensivas do usuário;
--   - comentários, curtidas, categorias e anexos dos posts do usuário;
--   - posts publicados pelo usuário.
--
-- a ordem é importante: primeiro são removidos os registros das tabelas
-- dependentes e, por último, os registros principais.
-- ---------------------------------------------------------------------

drop trigger if exists trg_before_delete_usuario$$

create trigger trg_before_delete_usuario
before delete on tbl_usuario
for each row
begin
    -- 1. remove os comentários publicados pelo usuário.
    delete from tbl_post_comentario
    where id_usuario = old.id;

    -- 2. remove as curtidas feitas pelo usuário.
    delete from tbl_post_curtida
    where id_usuario = old.id;

    -- 3. remove as notificações associadas ao usuário.
    delete from tbl_notificacao
    where id_usuario = old.id;

    -- 4. remove os vínculos com as ofensivas pertencentes ao usuário.
    --    essa exclusão precisa ocorrer antes da remoção das ofensivas.
    delete from tbl_usuario_missao_usuario_conteudo_educativo_ofensiva
    where id_ofensiva in (
        select id
        from tbl_ofensiva
        where id_usuario = old.id
    );

    -- 5. remove as ofensivas do usuário.
    delete from tbl_ofensiva
    where id_usuario = old.id;

    -- 6. remove comentários feitos por outros usuários nos posts
    --    que pertencem ao usuário que está sendo excluído.
    delete from tbl_post_comentario
    where id_post in (
        select id
        from tbl_post
        where id_usuario = old.id
    );

    -- 7. remove curtidas feitas por outros usuários nesses posts.
    delete from tbl_post_curtida
    where id_post in (
        select id
        from tbl_post
        where id_usuario = old.id
    );

    -- 8. remove as categorias associadas aos posts do usuário.
    delete from tbl_post_categoria
    where id_post in (
        select id
        from tbl_post
        where id_usuario = old.id
    );

    -- 9. remove os anexos associados aos posts do usuário.
    delete from tbl_post_anexo
    where id_post in (
        select id
        from tbl_post
        where id_usuario = old.id
    );

    -- 10. por último, remove os posts do usuário.
    delete from tbl_post
    where id_usuario = old.id;
end$$

delimiter ;
