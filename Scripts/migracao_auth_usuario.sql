-- ============================================================
-- MIGRAÇÃO: recuperação de senha do usuário (código por e-mail)
-- Pode ser executada mais de uma vez (só adiciona o que falta).
-- Rodar DEPOIS do Creates.sql.
-- ============================================================
USE db_vibeEco_2026;

SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='codigo_recuperacao');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN codigo_recuperacao VARCHAR(64) NULL", "SELECT 'codigo_recuperacao ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @c := (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA='db_vibeEco_2026' AND TABLE_NAME='tbl_usuario' AND COLUMN_NAME='codigo_expiracao');
SET @s := IF(@c=0, "ALTER TABLE tbl_usuario ADD COLUMN codigo_expiracao DATETIME NULL", "SELECT 'codigo_expiracao ok' AS aviso");
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
