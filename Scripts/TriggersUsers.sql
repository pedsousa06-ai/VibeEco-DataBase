 #Criando uma Trigger no MYSQL
 DELIMITER $
 CREATE TRIGGER tgrDeletePost
	before delete on tbl_post
		for each row
			BEGIN
				DELETE FROM tbl_post_curtida where id_post = old -- -> antigo ID que foi solicitado na tbl_post
            END$