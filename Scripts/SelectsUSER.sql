-- ***** BANCO DE DADOS VIBEECO *****
use db_vibeEco_2026;
show tables;
-- Seleciona todos os posts do mais recente ao mais antigo
CREATE OR REPLACE VIEW vwPostRecente AS
SELECT
    tbl_post.id AS id,
    tbl_usuario.nome AS nome_usuario,
    tbl_usuario.foto AS foto_usuario,
    tbl_post.descricao AS descricao_post,
    DATE_FORMAT(
        tbl_post.data_publicacao,
        '%d/%m/%Y %H:%i'
    ) AS data_publicacao,
    COUNT(tbl_post_curtida.id) AS qtde_curtida
FROM tbl_post
INNER JOIN tbl_usuario
    ON tbl_post.id_usuario = tbl_usuario.id
LEFT JOIN tbl_post_curtida
    ON tbl_post_curtida.id_post = tbl_post.id
GROUP BY
    tbl_post.id,
    tbl_usuario.nome,
    tbl_usuario.foto,
    tbl_post.descricao,
    tbl_post.data_publicacao
ORDER BY tbl_post.id DESC
LIMIT 0, 1000;

-- Seleciona todos os conteudos educativos que nao foram concluidos
CREATE OR REPLACE VIEW vwConteudoEducativo AS
SELECT
    tbl_usuario_conteudo_educativo.id AS id,
    tbl_usuario_conteudo_educativo.id_usuario AS id_usuario,
    tbl_usuario_conteudo_educativo.id_conteudo_educativo AS id_conteudo_educativo,
    tbl_conteudo_educativo.nome AS nome_conteudo_educativo,
    tbl_usuario_conteudo_educativo.concluido as status,
    DATE_FORMAT(
        tbl_usuario_conteudo_educativo.data_acesso,
        '%d/%m/%Y %H:%i'
    ) AS data_acesso
FROM tbl_usuario_conteudo_educativo
INNER JOIN tbl_conteudo_educativo
    ON tbl_usuario_conteudo_educativo.id_conteudo_educativo = tbl_conteudo_educativo.id
ORDER BY tbl_usuario_conteudo_educativo.data_acesso DESC
LIMIT 0, 1000;

select * from tbl_usuario_conteudo_educativo where id = 1;

-- Seleciona os post mais relevante utilizando como critério de filtro a quantidade de curtidas
create or replace view vwPostCurtidas as
	select
		tbl_post.id 				AS id,
		tbl_usuario.nome	 		as nome_usuario,
		tbl_usuario.foto			as foto_usuario,
		tbl_post.descricao 			as descricao_post, 
        DATE_FORMAT(data_publicacao, '%d/%m/%Y %H:%i') 	as data_publicacao_horario,
        COUNT(tbl_post_curtida.id)	as qtde_curtida
	from tbl_post
		inner join tbl_usuario
			on tbl_post.id_usuario = tbl_usuario.id
		left join tbl_post_curtida
			on tbl_post_curtida.id_post = tbl_post.id
	GROUP BY 
    tbl_post.id,
    tbl_usuario.nome,
    tbl_usuario.foto,
    tbl_post.descricao,
    tbl_post.data_publicacao
	order by qtde_curtida desc;
    
CREATE OR REPLACE VIEW vwRanking AS
SELECT
    u.id             AS id,
    u.nome           AS nome_usuario,
    u.foto           AS foto_usuario,
    u.total_xp       AS xp_usuario,
    e.nome           AS escolaridade,
    i.nome           AS instituicao,
    l.nome           AS nome_level,
    l.numero_level   AS nivel
FROM tbl_usuario as u
    INNER JOIN tbl_escolaridade as e ON u.id_escolaridade = e.id
    INNER JOIN tbl_instituicao  as i ON u.id_instituicao  = i.id
    INNER JOIN tbl_level_user   as l ON u.id_level        = l.id
WHERE u.exibir_ranking = TRUE
ORDER BY u.total_xp DESC;
    
DROP PROCEDURE IF EXISTS procListarMissaoEmAndamento;
DELIMITER $$
CREATE PROCEDURE procListarMissaoEmAndamento(IN p_id_usuario INT)
BEGIN
    SELECT
        tbl_usuario_missao.id                AS id_usuario_missao,
        tbl_usuario_missao.id_usuario        AS id_usuario,
        tbl_missao.id                        AS id_missao,
        tbl_missao.nome                      AS nome_missao,
        tbl_missao.coins                     AS qtde_coins,
        tbl_missao.total_xp_missao           AS qtde_xp,
        tbl_usuario_missao.progresso         AS progresso,
        GREATEST(DATEDIFF(tbl_missao.data_termino, CURDATE()), 0) AS prazo_dias,
        tbl_dificuldade.nome                 AS nome_dificuldade

    FROM tbl_usuario_missao
        INNER JOIN tbl_missao
            ON tbl_missao.id = tbl_usuario_missao.id_missao
        INNER JOIN tbl_dificuldade
            ON tbl_dificuldade.id = tbl_missao.id_dificuldade

    WHERE tbl_usuario_missao.id_usuario = p_id_usuario
      AND tbl_usuario_missao.status = 'EM_ANDAMENTO'       
      AND tbl_missao.data_termino > CURDATE()
      AND tbl_usuario_missao.progresso < 100

    ORDER BY tbl_missao.data_termino ASC;
END $$
DELIMITER ;
    
DROP PROCEDURE IF EXISTS procListarDadosInicio;
DELIMITER $$
CREATE PROCEDURE procListarDadosInicio(IN p_id_usuario INT)
BEGIN
    SELECT
        tbl_usuario.id                        AS id,
        tbl_usuario.nome                      AS nome_usuario,
        tbl_usuario.foto                      AS foto_usuario,
        tbl_usuario.coins                     AS coins_usuario,
        tbl_usuario.total_xp                  AS xp_usuario,

        level_atual.nome                      AS nome_level,
        level_atual.numero_level              AS nivel_atual,
        level_proximo.numero_level            AS proximo_nivel,
        level_proximo.nome                    AS nome_proximo_level,
        level_proximo.xp_necessario           AS xp_proximo_level,

        -- GREATEST() -> não permite que o valor fique negativo
        IF(level_proximo.id IS NULL, 0,
           GREATEST(level_proximo.xp_necessario - tbl_usuario.total_xp, 0)) AS xp_faltante,

        -- LEAST() -> limita o valor a no máximo 100
        -- ROUND() -> uma casa decimal
        IF(level_proximo.id IS NULL, 100,
           LEAST(100, ROUND(
               (tbl_usuario.total_xp - level_atual.xp_necessario) /
               (level_proximo.xp_necessario - level_atual.xp_necessario) * 100, 1
           ))) AS progresso_percentual,

        -- Missões e desafios por status
        (SELECT COUNT(*) FROM tbl_usuario_missao AS usuario_missao
          WHERE usuario_missao.id_usuario = tbl_usuario.id
            AND usuario_missao.status = 'EM_ANDAMENTO') AS qtd_missoes_em_andamento,

        (SELECT COUNT(*) FROM tbl_usuario_missao AS usuario_missao
          WHERE usuario_missao.id_usuario = tbl_usuario.id
            AND usuario_missao.status = 'CONCLUIDA') AS qtd_missoes_concluidas,

        (SELECT COUNT(*) FROM tbl_usuario_desafio AS usuario_desafio
          WHERE usuario_desafio.id_usuario = tbl_usuario.id
            AND usuario_desafio.status = 'EM_ANDAMENTO') AS qtd_desafios_ativos,

        -- Posição no ranking: 1 + quantos têm mais XP
        (SELECT COUNT(*) + 1 FROM tbl_usuario AS outros_usuarios
          WHERE outros_usuarios.total_xp > tbl_usuario.total_xp) AS posicao_ranking,

        -- Top X%: posição * 100 / total de usuários
        (SELECT ROUND((COUNT(*) + 1) * 100 / (SELECT COUNT(*) FROM tbl_usuario), 0)
           FROM tbl_usuario AS outros_usuarios
          WHERE outros_usuarios.total_xp > tbl_usuario.total_xp) AS ranking_top_percentual

    FROM tbl_usuario
        INNER JOIN tbl_level_user AS level_atual
            ON tbl_usuario.id_level = level_atual.id
        LEFT JOIN tbl_level_user AS level_proximo
            ON level_proximo.numero_level = level_atual.numero_level + 1
    WHERE tbl_usuario.id = p_id_usuario;
END $$
DELIMITER ;
    
-- Seleciona todos os comentarios recentes do post através do id
# Permite definir um delimitador de término da procedure
DELIMITER $$
# Permite criar uma procedure
### Na passagem de parametros existem 3 tipos de parametros, sendo: IN, OUT, INOUT
## IN 		-> Significa que a procedure recebe um parametro de entrada
## OUT 		-> Significa que a procedure devolve um parametro de saida
## INOUT 	-> Significa que a procedure recebe um parametro e devolve um parametro de saida
create procedure procListarComentariosByIdPost(IN id_post INT)
BEGIN
	if id_post > 0 then
		select	tbl_post_comentario.id				as id_post_comentario,
				tbl_post_comentario.id_post			as id_post,
                tbl_post_comentario.id_usuario		as id_usuario,
				tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as nome_comentario,
				DATE_FORMAT(data_comentario, '%d/%m/%Y %H:%i') as data_comentario
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		where tbl_post_comentario.id_post = id_post
		order by tbl_post_comentario.data_comentario desc;
	else
		select	tbl_post_comentario.id_post			as id_post,
				tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as nome_comentario,
				DATE_FORMAT(data_comentario, '%d/%m/%Y %H:%i') as data_comentario
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		order by tbl_post_comentario.data_comentario desc;
	end if;
END	$$
DELIMITER ;

DELIMITER $$
create procedure procListarComentariosByIdpostComentario(IN id_post_comentario INT)
BEGIN
	if id_post_comentario > 0 then
		select
				tbl_post_comentario.id				as id_post_comentario,
				tbl_post_comentario.id_post			as id_post,
				tbl_post_comentario.id_usuario		as id_usuario,
				tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as nome_comentario,
				DATE_FORMAT(data_comentario, '%d/%m/%Y %H:%i') as data_comentario
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		where tbl_post_comentario.id = id_post_comentario
		order by tbl_post_comentario.data_comentario desc;
	else
		select	tbl_post_comentario.id_usuario		as id_usuario,
				tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as nome_comentario,
				DATE_FORMAT(data_comentario, '%d/%m/%Y %H:%i') as data_comentario
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		order by tbl_post_comentario.data_comentario desc;
	end if;
END	$$
DELIMITER ;

DELIMITER $$
create procedure procListarComentariosByIdUsuario(IN id_usuario INT)
BEGIN
	if id_usuario > 0 then
		select
				tbl_post_comentario.id				as id_post_comentario,
				tbl_post_comentario.id_post			as id_post,
				tbl_post_comentario.id_usuario		as id_usuario,
				tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as post_comentarios,
				DATE_FORMAT(data_comentario, '%d/%m/%Y %H:%i') as data_comentario
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		where tbl_post_comentario.id_usuario = id_usuario
		order by tbl_post_comentario.data_comentario desc;
	else
		select	tbl_post_comentario.id_usuario		as id_usuario,
				tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as post_comentarios,
				DATE_FORMAT(data_comentario, '%d/%m/%Y %H:%i') as data_comentario
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		order by tbl_post_comentario.data_comentario desc;
	end if;
END	$$
DELIMITER ;

-- Permite visualizar todos os anexos utilizando como critério de filtro o id do post
DELIMITER $$
CREATE PROCEDURE procListarPostAnexos(IN id_post_anexo INT)
BEGIN
    SELECT
        tbl_usuario.nome 		AS nome_usuario,
        tbl_anexo.nome 			AS tipo_anexo,
        tbl_anexo.endereco_url 	AS endereco_url
    FROM tbl_post_anexo
        INNER JOIN tbl_post
            ON tbl_post_anexo.id_post = tbl_post.id
        INNER JOIN tbl_usuario
            ON tbl_post.id_usuario = tbl_usuario.id
        INNER JOIN tbl_anexo
            ON tbl_post_anexo.id_anexo = tbl_anexo.id
    WHERE tbl_post.id = id_post_anexo;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarPostCategorias(IN id_post_categoria INT)
BEGIN
	SELECT
		tbl_categoria.nome 	AS nome_categoria
	FROM tbl_post_categoria
		INNER JOIN tbl_categoria
			ON tbl_post_categoria.id_categoria = tbl_categoria.id
	WHERE tbl_post_categoria.id = id_post_categoria
	ORDER BY tbl_categoria.nome ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarCategoriasByIdPost(IN id_post_categoria INT)
BEGIN
	SELECT
		tbl_categoria.nome 	AS nome_categoria
	FROM tbl_post_categoria
		INNER JOIN tbl_categoria
			ON tbl_post_categoria.id_categoria = tbl_categoria.id
	WHERE tbl_post_categoria.id_post = id_post_categoria
	ORDER BY tbl_categoria.nome ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarPostByIdCategoria(IN id_post_categoria INT)
BEGIN
	SELECT
		tbl_categoria.nome 	AS nome_categoria
	FROM tbl_post_categoria
		INNER JOIN tbl_categoria
			ON tbl_post_categoria.id_categoria = tbl_categoria.id
	WHERE tbl_post_categoria.id_categoria = id_post_categoria
	ORDER BY tbl_categoria.nome ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarPostViaId(IN id_post INT)
BEGIN
    SELECT
		tbl_post.id 		AS id,
        tbl_usuario.nome 	AS nome_usuario,
        tbl_usuario.foto 	AS foto_usuario,
        tbl_post.descricao 	AS descricao_post,
        DATE_FORMAT(tbl_post.data_publicacao, '%d/%m/%Y %H:%i') AS data_publicacao,
        COUNT(tbl_post_curtida.id) AS qtde_curtida
    FROM tbl_post
        INNER JOIN tbl_usuario
            ON tbl_post.id_usuario = tbl_usuario.id
        LEFT JOIN tbl_post_curtida
            ON tbl_post_curtida.id_post = tbl_post.id
    WHERE tbl_post.id = id_post
    GROUP BY
        tbl_post.id,
        tbl_usuario.nome,
        tbl_usuario.foto,
        tbl_post.descricao,
        tbl_post.data_publicacao
    ORDER BY tbl_post.id DESC
    LIMIT 0, 1000;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarPostAnexosByIdPost(IN id_post_anexo INT)
BEGIN
	SELECT
		tbl_anexo.id AS id_anexo,
		tbl_anexo.nome 			AS nome_anexo,
        tbl_anexo.endereco_url 	as endereco_url
	FROM tbl_post_anexo
		INNER JOIN tbl_anexo
			ON tbl_post_anexo.id_anexo = tbl_anexo.id
	WHERE tbl_post_anexo.id_post = id_post_anexo
	ORDER BY tbl_anexo.nome ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarPostAnexosByIdAnexo(IN id_post_anexo INT)
BEGIN
	SELECT
		tbl_anexo.id AS id_anexo,
		tbl_anexo.nome 	AS nome_anexo,
        tbl_anexo.endereco_url 	as endereco_url
	FROM tbl_post_anexo
		INNER JOIN tbl_anexo
			ON tbl_post_anexo.id_anexo = tbl_anexo.id
	WHERE tbl_post_anexo.id_anexo = id_post_anexo
	ORDER BY tbl_anexo.nome ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarByIdPostAnexos(IN id_post_anexo INT)
BEGIN
	SELECT
		tbl_anexo.id AS id_anexo,
		tbl_anexo.nome 	AS nome_anexo,
        tbl_anexo.endereco_url 	as endereco_url
	FROM tbl_post_anexo
		INNER JOIN tbl_anexo
			ON tbl_post_anexo.id_anexo = tbl_anexo.id
	WHERE tbl_post_anexo.id_post = id_post_anexo
	ORDER BY tbl_anexo.nome ASC;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE procListarCurtidasByIdPost(IN id_post INT)
BEGIN
    SELECT
        COUNT(tbl_post_curtida.id)
        -- OVER() -> Realiza cálculos sem reduzir as linhas.
		-- PARTITION BY	-> Divide os registros em grupos para os cálculos da janela.
            OVER (PARTITION BY tbl_post_curtida.id_post) AS qtde_curtida,
		tbl_post_curtida.id				as id_post_curtida,
        tbl_post_curtida.id_post AS id_post,
        tbl_post_curtida.id_usuario as id_usuario,
        tbl_usuario.nome AS nome_usuario,
        tbl_usuario.foto AS foto_usuario,
        DATE_FORMAT(
            tbl_post_curtida.data_curtida,
            '%d/%m/%Y %H:%i'
        ) AS data_curtida
    FROM tbl_post_curtida

    INNER JOIN tbl_usuario
        ON tbl_post_curtida.id_usuario = tbl_usuario.id

    WHERE id_post <= 0
       OR tbl_post_curtida.id_post = id_post

    ORDER BY tbl_post_curtida.data_curtida DESC;
END $$
DELIMITER ;

DELIMITER $$
create procedure procListarCurtidasByIdUsuario(IN id_usuario INT)
BEGIN
    SELECT
        COUNT(tbl_post_curtida.id)
        -- OVER() -> Realiza cálculos sem reduzir as linhas.
		-- PARTITION BY	-> Divide os registros em grupos para os cálculos da janela.
            OVER (PARTITION BY tbl_post_curtida.id_post) AS qtde_curtida,
		tbl_post_curtida.id				as id_post_curtida,
        tbl_post_curtida.id_post AS id_post,
        tbl_post_curtida.id_usuario as id_usuario,
        tbl_usuario.nome AS nome_usuario,
        tbl_usuario.foto AS foto_usuario,
        DATE_FORMAT(
            tbl_post_curtida.data_curtida,
            '%d/%m/%Y %H:%i'
        ) AS data_curtida
    FROM tbl_post_curtida

    INNER JOIN tbl_usuario
        ON tbl_post_curtida.id_usuario = tbl_usuario.id

    WHERE id_usuario <= 0
       OR tbl_post_curtida.id_usuario = id_usuario

    ORDER BY tbl_post_curtida.data_curtida DESC;
END	$$
DELIMITER ;

DELIMITER $$
create procedure procListarCurtidasByIdPostCurtida(IN id_post_curtida INT)
BEGIN
    SELECT
        COUNT(tbl_post_curtida.id)
        -- OVER() -> Realiza cálculos sem reduzir as linhas.
		-- PARTITION BY	-> Divide os registros em grupos para os cálculos da janela.
            OVER (PARTITION BY tbl_post_curtida.id_post) AS qtde_curtida,
		tbl_post_curtida.id				as id_post_curtida,
        tbl_post_curtida.id_post AS id_post,
        tbl_post_curtida.id_usuario as id_usuario,
        tbl_usuario.nome AS nome_usuario,
        tbl_usuario.foto AS foto_usuario,
        DATE_FORMAT(
            tbl_post_curtida.data_curtida,
            '%d/%m/%Y %H:%i'
        ) AS data_curtida
    FROM tbl_post_curtida

    INNER JOIN tbl_usuario
        ON tbl_post_curtida.id_usuario = tbl_usuario.id

    WHERE id_post_curtida <= 0
       OR tbl_post_curtida.id = id_post_curtida

    ORDER BY tbl_post_curtida.data_curtida DESC;
END	$$
DELIMITER ;

# Permite visualizar todas as procedures existentes no banco de dados
show procedure status;
#Executa a procedure existente no banco
call procListarMissaoEmAndamento(2);
call procListarPostAnexos(2);
call procListarComentariosByIdpostComentario(1);
call procListarPostViaId(1);
#Permite apagar procedures existentes no banco
-- drop procedure procListarPostAnexosByIdPost;
-- drop procedure procListarComentariosByIdpostComentario;
#Permite apagar uma view no banco
-- drop view vwPostCurtidas;
