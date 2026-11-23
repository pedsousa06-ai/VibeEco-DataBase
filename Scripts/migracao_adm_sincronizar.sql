-- ============================================================
-- MIGRAÇÃO: deixa um banco antigo igual ao que o back-end ADM espera
-- (missões, desafios e conteúdos educativos).
-- Pode ser executada várias vezes: só cria o que ainda não existe.
-- Rodar DEPOIS do Creates.sql / Inserts.sql.
-- ============================================================
USE db_vibeEco_2026;

-- helper: adiciona coluna se não existir  (tabela, coluna, definição)
DROP PROCEDURE IF EXISTS sp_add_coluna;
DELIMITER $$
CREATE PROCEDURE sp_add_coluna(IN t VARCHAR(64), IN c VARCHAR(64), IN def VARCHAR(255))
BEGIN
    IF (SELECT COUNT(*) FROM information_schema.COLUMNS
         WHERE TABLE_SCHEMA = 'db_vibeEco_2026' AND TABLE_NAME = t AND COLUMN_NAME = c) = 0 THEN
        SET @sql = CONCAT('ALTER TABLE ', t, ' ADD COLUMN ', c, ' ', def);
        PREPARE st FROM @sql; EXECUTE st; DEALLOCATE PREPARE st;
    END IF;
END$$
DELIMITER ;

-- 1. Missões: dica + etapas
CALL sp_add_coluna('tbl_missao', 'dica', 'TEXT NULL');

CREATE TABLE IF NOT EXISTS tbl_missao_etapa(
    id int not null primary key auto_increment,
    id_missao int not null,
    titulo varchar(150) not null,
    xp int not null,
    ordem int not null,
    constraint FK_MISSAO_MISSAOETAPA foreign key (id_missao) references tbl_missao(id),
    constraint UQ_MISSAO_ORDEM unique (id_missao, ordem)
);

-- 2. Conteúdos: tempo de leitura e XP
CALL sp_add_coluna('tbl_conteudo_educativo', 'duracao_leitura', 'INT NOT NULL DEFAULT 5');
CALL sp_add_coluna('tbl_conteudo_educativo', 'qtde_xp', 'INT NOT NULL DEFAULT 0');

-- 3. Desafios: tipo (Individual/Coletivo) e meta de participantes
CREATE TABLE IF NOT EXISTS tbl_tipo_desafio(
    id int not null primary key auto_increment,
    nome varchar(20) not null
);
INSERT INTO tbl_tipo_desafio (id, nome)
SELECT 1, 'Individual' WHERE NOT EXISTS (SELECT 1 FROM tbl_tipo_desafio WHERE id = 1);
INSERT INTO tbl_tipo_desafio (id, nome)
SELECT 2, 'Coletivo' WHERE NOT EXISTS (SELECT 1 FROM tbl_tipo_desafio WHERE id = 2);

CALL sp_add_coluna('tbl_desafio', 'id_tipo_desafio', 'INT NOT NULL DEFAULT 1');
CALL sp_add_coluna('tbl_desafio', 'meta_participantes', 'INT NULL');

DROP PROCEDURE IF EXISTS sp_add_coluna;

-- conferir
SELECT 'ok' AS resultado,
       (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_desafio' AND COLUMN_NAME IN ('id_tipo_desafio','meta_participantes')) AS colunas_desafio,
       (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_conteudo_educativo' AND COLUMN_NAME IN ('duracao_leitura','qtde_xp')) AS colunas_conteudo,
       (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_missao' AND COLUMN_NAME='dica') AS coluna_missao;
