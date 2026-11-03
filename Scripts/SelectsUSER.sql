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
call procListarCurtidasByIdUsuario(1);
call procListarPostAnexos(2);
call procListarComentariosByIdpostComentario(1);
call procListarPostViaId(1);
#Permite apagar procedures existentes no banco
-- drop procedure procListarCurtidasByIdPostCurtida;
-- drop procedure procListarComentariosByIdpostComentario;
#Permite apagar uma view no banco
-- drop view vwPostCurtidas;

select * from vwPostRecente;
