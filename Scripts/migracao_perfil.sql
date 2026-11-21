-- ============================================================
-- MIGRAÇÃO: campos da tela de Perfil do usuário
-- Pode ser executada mais de uma vez (só adiciona o que falta).
-- Rodar DEPOIS do Creates.sql / Inserts.sql / SelectsUSER.sql.
-- ============================================================
USE db_vibeEco_2026;

-- 1. Nome público (ranking e interações)
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='nome_publico');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN nome_publico VARCHAR(50) NULL", "SELECT 'nome_publico ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 2. Curso
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='curso');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN curso VARCHAR(100) NULL", "SELECT 'curso ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 3. Localização
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='localizacao');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN localizacao VARCHAR(100) NULL", "SELECT 'localizacao ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 4. Bio (até 160 caracteres, igual ao limite da tela)
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='bio');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN bio VARCHAR(160) NULL", "SELECT 'bio ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 5. Matrícula (somente leitura na tela)
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='matricula');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN matricula VARCHAR(30) NULL", "SELECT 'matricula ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- 6. Data de cadastro ("Desde ..."). Usuários que já existiam ficam com a data desta migração.
SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='data_cadastro');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN data_cadastro DATETIME NULL DEFAULT CURRENT_TIMESTAMP", "SELECT 'data_cadastro ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
