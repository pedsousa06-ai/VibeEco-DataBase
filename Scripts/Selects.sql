-- ***** BANCO DE DADOS VIBEECO *****

use db_vibeEco_2029;

-- Seleciona todos os posts do mais recente ao mais antigo
create view vwPostRecente as
	SELECT 
		tbl_usuario.nome 			AS nome_usuario,
		tbl_usuario.foto 			AS foto_usuario,
		tbl_post.descricao 			AS descricao_post, 
		tbl_post.data_publicacao 	AS data_hora_publicacao,
		COUNT(tbl_post_curtida.id) 	AS qtde_curtida
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
	LIMIT 0, 1000; -- Limite de posts que o select pode trazer
    
    
-- Seleciona os post mais relevante utilizando como critério de filtro a quantidade de curtidas
create view vwPostCurtidas as
	select 	tbl_usuario.nome	 	as nome_usuario,
		tbl_usuario.foto			as foto_usuario,
		tbl_post.descricao 			as descricao_post, 
        tbl_post.data_publicacao 	as data_publicacao_horario,
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
create procedure procListarComentarios(IN id_post_comentario INT)
BEGIN
	if id_post_comentario > 0 then
		select	tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as post_comentarios,
				tbl_post_comentario.data_comentario as data_comentarios
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		where tbl_post_comentario.id_post = id_post_comentario
		order by tbl_post_comentario.data_comentario desc;
	else
		select	tbl_usuario.nome					as nome_usuario,
				tbl_usuario.foto					as foto_usuario,
				tbl_post_comentario.comentario		as post_comentarios,
				tbl_post_comentario.data_comentario as data_comentarios
		from tbl_post_comentario
			inner join tbl_usuario
				on tbl_post_comentario.id_usuario = tbl_usuario.id
		order by tbl_post_comentario.data_comentario desc;
	end if;
END	$$

DELIMITER $$
create procedure procListarPostAnexos(IN id_post_anexo INT)
BEGIN
	



END $$

# Permite visualizar todas as procedures existentes no banco de dados
show procedure status;
#Executa a procedure existente no banco
call procListarComentarios(2);
#Permite apagar procedures existentes no banco
drop procedure procListarComentarios;
        
	
    
        