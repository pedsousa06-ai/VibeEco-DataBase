-- ======================================================
-- ===== ARQUIVO DE SELECTS DA API DO ADMINISTRADOR =====
-- ======================================================

-- ***** BANCO DE DADOS VIBEECO *****
use db_vibeEco_2029;

-- ***** RETORNA TODOS OS DADOS DA TABELA DE DESAFIOS *****
select	tbl_desafio.id, tbl_desafio.nome, tbl_desafio.descricao, tbl_desafio.super_coins, tbl_desafio.data_inicio, tbl_desafio.data_termino,
		tbl_dificuldade.nome as dificuldade
			from tbl_desafio
				inner join tbl_dificuldade
					on tbl_desafio.id_dificuldade = tbl_dificuldade.id
	order by tbl_desafio.id desc;
    
    
-- ***** RETORNA UM DADO DA TABELA DE DESAFIOS PELO ID *****    
select	tbl_desafio.id, tbl_desafio.nome, tbl_desafio.descricao, tbl_desafio.super_coins, tbl_desafio.data_inicio, tbl_desafio.data_termino,
		tbl_dificuldade.nome as dificuldade
			from tbl_desafio
				inner join tbl_dificuldade
					on tbl_desafio.id_dificuldade = tbl_dificuldade.id
	where tbl_desafio.id = 1;
    
    
-- ***** RETORNA TODOS OS DADOS DA TABELA DE MISSÕES *****
select 	tbl_missao.id ,tbl_missao.nome, tbl_missao.descricao, tbl_missao.coins, tbl_missao.total_xp_missao, tbl_missao.data_inicio, tbl_missao.data_termino,
		tbl_dificuldade.nome as dificuldade
			from tbl_missao
				inner join tbl_dificuldade
					on tbl_missao.id_dificuldade = tbl_dificuldade.id
	order by tbl_missao.id desc;
    
    
-- ***** RETORNA UM DADO DA TABELA DE MISSÕES PELO ID *****
select 	tbl_missao.id ,tbl_missao.nome, tbl_missao.descricao, tbl_missao.coins, tbl_missao.total_xp_missao, tbl_missao.data_inicio, tbl_missao.data_termino,
		tbl_dificuldade.nome as dificuldade
			from tbl_missao
				inner join tbl_dificuldade
					on tbl_missao.id_dificuldade = tbl_dificuldade.id
	where tbl_missao.id = 1;
    
    
-- ***** RETORNA TODOS OS DADOS DA TABELA DE USUARIOS *****
select	tbl_usuario.id, tbl_usuario.nome, tbl_usuario.email, tbl_usuario.foto, tbl_usuario.total_xp, tbl_usuario.coins, tbl_usuario.data_ultimo_acesso,
		tbl_escolaridade.nome as escolaridade,
        tbl_status.is_active as status_usuario,
        tbl_instituicao.nome as instituicao,
        tbl_nivel_acesso.nivel as nivel_acesso,
        tbl_level_user.nome as level
			from tbl_usuario
				inner join tbl_escolaridade
					on tbl_usuario.id_escolaridade = tbl_escolaridade.id
				inner join tbl_status
					on tbl_usuario.id_status = tbl_status.id
				inner join tbl_instituicao
					on tbl_usuario.id_instituicao = tbl_instituicao.id
				inner join tbl_nivel_acesso
					on tbl_usuario.id_nivel_acesso = tbl_nivel_acesso.id				
				inner join tbl_level_user
					on tbl_usuario.id_level = tbl_level_user.id		
	order by tbl_usuario.id desc;
    
    
-- ***** RETORNA UM DADO DA TABELA DE USUARIOS PELO ID *****
select	tbl_usuario.id, tbl_usuario.nome, tbl_usuario.email, tbl_usuario.foto, tbl_usuario.total_xp, tbl_usuario.coins, tbl_usuario.data_ultimo_acesso,
		tbl_escolaridade.nome as escolaridade,
        tbl_status.is_active as status_usuario,
        tbl_instituicao.nome as instituicao,
        tbl_nivel_acesso.nivel as nivel_acesso,
        tbl_level_user.nome as level
			from tbl_usuario
				inner join tbl_escolaridade
					on tbl_usuario.id_escolaridade = tbl_escolaridade.id
				inner join tbl_status
					on tbl_usuario.id_status = tbl_status.id
				inner join tbl_instituicao
					on tbl_usuario.id_instituicao = tbl_instituicao.id
				inner join tbl_nivel_acesso
					on tbl_usuario.id_nivel_acesso = tbl_nivel_acesso.id				
				inner join tbl_level_user
					on tbl_usuario.id_level = tbl_level_user.id		
	where tbl_usuario.id = 1;
    
    
-- ***** RETORNA TODOS OS DADOS DA TABELA DE USUARIOS ADM *****
select	tbl_usuario_adm.id, tbl_usuario_adm.email, tbl_usuario_adm.senha, 
		tbl_nivel_acesso.nivel as nivel_acesso
			from tbl_usuario_adm
				inner join tbl_nivel_acesso
					on tbl_usuario_adm.id_nivel_acesso = tbl_nivel_acesso.id
	order by tbl_usuario_adm.id desc;
    
    
-- ***** RETORNA UM DADO DA TABELA DE USUARIOS ADM PELO ID *****
select	tbl_usuario_adm.id, tbl_usuario_adm.email, tbl_usuario_adm.senha, 
		tbl_nivel_acesso.nivel as nivel_acesso
			from tbl_usuario_adm
				inner join tbl_nivel_acesso
					on tbl_usuario_adm.id_nivel_acesso = tbl_nivel_acesso.id
	where tbl_usuario_adm.id = 1;
    