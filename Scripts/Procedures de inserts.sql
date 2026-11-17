-- ============================================================
-- Conclui uma etapa de missão para um usuário.
-- Se for a última etapa, conclui a missão e paga os coins.
-- Parâmetros: p_id_usuario (quem concluiu) e p_id_etapa (qual etapa)
-- ============================================================
DROP PROCEDURE IF EXISTS procConcluirEtapa;
DELIMITER $$
CREATE PROCEDURE procConcluirEtapa(IN p_id_usuario INT, IN p_id_etapa INT)
BEGIN
    -- --------------------------------------------------------
    -- VARIÁVEIS (guardam valores temporários durante a execução)
    -- v_ = variável | p_ = parâmetro
    -- DECLARE sempre vem no começo da procedure
    -- --------------------------------------------------------
    DECLARE v_id_missao         INT;          -- missão à qual a etapa pertence
    DECLARE v_id_usuario_etapa INT;
    DECLARE v_xp_etapa          INT;          -- XP que a etapa vale
    DECLARE v_data_termino      DATE;         -- prazo final da missão
    DECLARE v_id_usuario_missao INT;          -- id do vínculo usuário-missão
    DECLARE v_status            VARCHAR(20);  -- status atual do vínculo
    DECLARE v_total_etapas      INT;          -- quantas etapas a missão tem
    DECLARE v_concluidas        INT;          -- quantas o usuário já concluiu
    DECLARE v_progresso         INT;          -- porcentagem de 0 a 100

    -- --------------------------------------------------------
    -- TRATAMENTO DE ERRO (equivalente ao try/catch do JavaScript)
    -- Se qualquer comando abaixo falhar, o MySQL cai aqui
    -- EXIT = interrompe a procedure depois de executar o bloco
    -- --------------------------------------------------------
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;   -- desfaz tudo que foi gravado desde o START TRANSACTION
        RESIGNAL;   -- repassa o erro original para o Node (senão ele seria engolido)
    END;

    -- Inicia a transação: nada é gravado de forma definitiva até o COMMIT
    -- (é o "tudo ou nada")
    START TRANSACTION;

    -- --------------------------------------------------------
    -- PASSO 1: A etapa existe? De qual missão ela é?
    -- SELECT ... INTO guarda o resultado nas variáveis, na mesma
    -- ordem das colunas
    -- --------------------------------------------------------
    SELECT me.id_missao, me.xp, m.data_termino
      INTO v_id_missao, v_xp_etapa, v_data_termino
      FROM tbl_missao_etapa me
     INNER JOIN tbl_missao m ON m.id = me.id_missao  -- traz o prazo da missão
     WHERE me.id = p_id_etapa;

    -- Se a etapa não existe, o SELECT não acha nada e a variável fica NULL
    IF v_id_missao IS NULL THEN
        -- SIGNAL cria um erro de propósito (como o throw new Error do JS)
        -- 45000 = código padrão do MySQL para erro definido pelo usuário
        -- MESSAGE_TEXT = texto que chega no Node, usado para escolher o status HTTP
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ETAPA_NAO_ENCONTRADA';
    END IF;

    -- --------------------------------------------------------
    -- PASSO 2: O usuário está nessa missão?
    -- FOR UPDATE trava a linha até o fim da transação, para que duas
    -- requisições simultâneas (ex: clique duplo) não leiam o estado
    -- antigo ao mesmo tempo e calculem o progresso errado
    -- --------------------------------------------------------
    SELECT id, status
      INTO v_id_usuario_missao, v_status
      FROM tbl_usuario_missao
     WHERE id_usuario = p_id_usuario
       AND id_missao  = v_id_missao
       FOR UPDATE;

    -- Se não achou vínculo, o usuário nunca aceitou essa missão
    IF v_id_usuario_missao IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'USUARIO_NAO_VINCULADO_A_MISSAO';
    END IF;

    -- Só aceita etapa de missão em andamento (barra CONCLUIDA e CANCELADA)
    IF v_status <> 'EM_ANDAMENTO' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'MISSAO_NAO_ESTA_EM_ANDAMENTO';
    END IF;

    -- Não aceita etapa depois do prazo da missão
    IF v_data_termino < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'MISSAO_EXPIRADA';
    END IF;

    -- --------------------------------------------------------
    -- PASSO 3: Registra a conclusão da etapa
    -- A data_conclusao entra sozinha (DEFAULT CURRENT_TIMESTAMP)
    -- Se o usuário já concluiu essa etapa, a constraint UQ_USUARIO_ETAPA
    -- gera o erro 1062 (entrada duplicada) e o handler faz o rollback
    -- --------------------------------------------------------
    INSERT INTO tbl_usuario_etapa (id_usuario, id_etapa)
    VALUES (p_id_usuario, p_id_etapa);
    
    -- Recupera o ID gerado pelo AUTO_INCREMENT
	SET v_id_usuario_etapa = LAST_INSERT_ID();

    -- --------------------------------------------------------
    -- PASSO 4: Compara total de etapas x etapas concluídas
    -- --------------------------------------------------------

    -- Quantas etapas a missão tem no total
    SELECT COUNT(*) INTO v_total_etapas
      FROM tbl_missao_etapa
     WHERE id_missao = v_id_missao;

    -- Quantas etapas DESSA missão o usuário já concluiu
    -- O JOIN é necessário porque tbl_usuario_etapa só guarda o id da etapa
    -- e não sabe a qual missão ela pertence
    SELECT COUNT(*) INTO v_concluidas
      FROM tbl_usuario_etapa ue
     INNER JOIN tbl_missao_etapa me ON me.id = ue.id_etapa
     WHERE me.id_missao = v_id_missao
       AND ue.id_usuario = p_id_usuario;

    -- --------------------------------------------------------
    -- PASSO 5: Dá o XP da etapa ao usuário
    -- COALESCE(total_xp, 0) troca NULL por 0, porque NULL + número = NULL
    -- --------------------------------------------------------
    UPDATE tbl_usuario
       SET total_xp = COALESCE(total_xp, 0) + v_xp_etapa
     WHERE id = p_id_usuario;

    -- --------------------------------------------------------
    -- PASSO 6: Atualiza o vínculo usuário-missão
    -- Compara as CONTAGENS (e não a porcentagem), assim a missão só
    -- conclui quando todas as etapas foram realmente feitas
    -- --------------------------------------------------------
    IF v_concluidas >= v_total_etapas THEN

        -- Última etapa: conclui a missão
        UPDATE tbl_usuario_missao
           SET progresso      = 100,
               status         = 'CONCLUIDA',
               data_conclusao = NOW()
         WHERE id = v_id_usuario_missao;

        -- Paga os coins da missão ao usuário
        -- UPDATE com JOIN: traz a tabela da missão para dentro do update
        -- para poder usar m.coins na conta
        UPDATE tbl_usuario u
         INNER JOIN tbl_missao m ON m.id = v_id_missao
           SET u.coins = COALESCE(u.coins, 0) + m.coins
         WHERE u.id = p_id_usuario;

        -- Atualiza as variáveis para o SELECT final refletir a conclusão
        SET v_status    = 'CONCLUIDA';
        SET v_progresso = 100;

    ELSE

        -- Ainda faltam etapas: só atualiza a porcentagem
        -- FLOOR arredonda para baixo, assim nunca chega em 100% antes da
        -- última etapa (ex: 199/200 = 99,5% vira 99 e não 100)
        SET v_progresso = FLOOR(v_concluidas * 100 / v_total_etapas);

        UPDATE tbl_usuario_missao
           SET progresso = v_progresso
         WHERE id = v_id_usuario_missao;

    END IF;

    -- Chegou até aqui sem erro: grava tudo de forma definitiva
    COMMIT;
    SELECT 
    v_id_usuario_etapa AS id,
    p_id_usuario AS id_usuario,
    p_id_etapa AS id_etapa,
    v_progresso AS progresso,
    v_status AS status;
END $$
DELIMITER ;
