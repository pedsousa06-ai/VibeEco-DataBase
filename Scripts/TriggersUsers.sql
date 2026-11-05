 -- Trigger para deletar o post e as suas relacoes com outras tabelas
 DELIMITER $
 CREATE TRIGGER tgrDeletePost
	before delete on tbl_post
		for each row
			BEGIN
				DELETE FROM tbl_post_curtida 	where id_post = old.id; -- -> antigo ID que foi solicitado na tbl_post e que sirva como criterio de filtro para deletar nas demais tabelas
				DELETE FROM tbl_post_comentario where id_post = old.id;
                DELETE FROM tbl_post_anexo 		where id_post = old.id;
				DELETE FROM tbl_post_categoria 	where id_post = old.id;
            END$