-- ============================================================
-- Recria o banco db_vibeEco_2026 do zero, com os dados de exemplo, na ordem certa.
-- ATENÇÃO: apaga o banco existente (o Creates.sql começa com DROP DATABASE).
--
-- Rode de DENTRO da pasta Scripts, no cliente de linha de comando do MySQL:
--     cd Scripts
--     mysql -u root -p --default-character-set=utf8mb4 < rodar_tudo.sql
-- (SOURCE e DELIMITER não funcionam em abas do Workbench; lá, abra e execute cada arquivo na ordem abaixo.)
-- ============================================================
SOURCE Creates.sql;
SOURCE Inserts.sql;
SOURCE Procedures de inserts.sql;
SOURCE TriggersAdministrador.sql;
SOURCE TriggersUsers.sql;
SOURCE SelectsUSER.sql;
SOURCE migracao_perfil.sql;
SOURCE migracao_adm_sincronizar.sql;
