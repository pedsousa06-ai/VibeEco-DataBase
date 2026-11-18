-- Migração: Adição de colunas para recuperação de senha na tabela tbl_usuario_adm
USE db_vibeEco_2026;

ALTER TABLE tbl_usuario_adm 
    ADD COLUMN codigo_recuperacao VARCHAR(10) NULL,
    ADD COLUMN codigo_expiracao DATETIME NULL;
