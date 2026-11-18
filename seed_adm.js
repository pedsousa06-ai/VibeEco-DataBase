const mysql = require('../backend/node_modules/mysql2/promise');

async function seed() {
  const connection = await mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'bcd127',
    database: 'db_vibeeco_2026'
  });

  console.log('Conectado ao MySQL com sucesso.');

  // 1. Nível de acesso
  const [niveis] = await connection.query('SELECT COUNT(*) as c FROM tbl_nivel_acesso');
  if (niveis[0].c === 0) {
    console.log('Populando tbl_nivel_acesso...');
    await connection.query(`
      INSERT INTO tbl_nivel_acesso (id, nivel) VALUES
      (1, 'Administrador'),
      (2, 'Usuário'),
      (3, 'Moderador');
    `);
  }

  // 2. Status
  const [status] = await connection.query('SELECT COUNT(*) as c FROM tbl_status');
  if (status[0].c === 0) {
    console.log('Populando tbl_status...');
    await connection.query(`
      INSERT INTO tbl_status (id, is_active) VALUES
      (1, TRUE),
      (2, FALSE),
      (3, TRUE);
    `);
  }

  // 3. Escolaridade
  const [escolaridade] = await connection.query('SELECT COUNT(*) as c FROM tbl_escolaridade');
  if (escolaridade[0].c === 0) {
    console.log('Populando tbl_escolaridade...');
    await connection.query(`
      INSERT INTO tbl_escolaridade (id, nome) VALUES
      (1, 'Ensino Fundamental'),
      (2, 'Ensino Médio'),
      (3, 'Ensino Superior');
    `);
  }

  // 4. Level User
  const [level] = await connection.query('SELECT COUNT(*) as c FROM tbl_level_user');
  if (level[0].c === 0) {
    console.log('Populando tbl_level_user...');
    await connection.query(`
      INSERT INTO tbl_level_user (id, nome, numero_level, xp_necessario) VALUES
      (1, 'Iniciante', 1, 0),
      (2, 'Intermediário', 2, 500),
      (3, 'Avançado', 3, 1200);
    `);
  }

  // 5. Instituição
  const [inst] = await connection.query('SELECT COUNT(*) as c FROM tbl_instituicao');
  if (inst[0].c === 0) {
    console.log('Populando tbl_instituicao...');
    await connection.query(`
      INSERT INTO tbl_instituicao (id, nome, descricao) VALUES
      (1, 'Escola Estadual São Paulo', 'Instituição de ensino estadual.'),
      (2, 'Colégio VibeEco', 'Instituição parceira da plataforma VibeEco.'),
      (3, 'Instituto Verde', 'Instituição voltada à educação e conscientização ambiental.');
    `);
  }

  // 6. Usuários Administradores
  const [admins] = await connection.query('SELECT COUNT(*) as c FROM tbl_usuario_adm');
  if (admins[0].c === 0) {
    console.log('Populando tbl_usuario_adm...');
    await connection.query(`
      INSERT INTO tbl_usuario_adm (email, senha, id_nivel_acesso) VALUES
      ('admin1@vibeeco.com', 'admin123', 1),
      ('admin2@vibeeco.com', 'admin456', 1),
      ('moderador@vibeeco.com', 'moderador123', 3);
    `);
  }

  // 7. Usuários comuns
  const [usuarios] = await connection.query('SELECT COUNT(*) as c FROM tbl_usuario');
  if (usuarios[0].c === 0) {
    console.log('Populando tbl_usuario...');
    await connection.query(`
      INSERT INTO tbl_usuario (
        id, nome, email, senha, foto, total_xp, coins, data_ultimo_acesso,
        id_escolaridade, id_status, id_instituicao, id_nivel_acesso, id_level, exibir_ranking
      ) VALUES
      (1, 'Lucas Oliveira', 'lucas.oliveira@email.com', 'senha123', 'https://vibeeco.com/fotos/lucas.png', 350, 100, '2026-11-10 08:00:00', 1, 1, 1, 2, 1, TRUE),
      (2, 'Mariana Santos', 'mariana.santos@email.com', 'senha456', 'https://vibeeco.com/fotos/mariana.png', 700, 250, '2026-11-10 08:30:00', 2, 1, 2, 2, 2, TRUE),
      (3, 'Pedro Almeida', 'pedro.almeida@email.com', 'senha789', 'https://vibeeco.com/fotos/pedro.png', 1450, 400, '2026-11-10 09:00:00', 3, 1, 3, 2, 3, FALSE);
    `);
  }

  console.log('Verificando administradores cadastrados:');
  const [resAdmins] = await connection.query('SELECT id, email, id_nivel_acesso FROM tbl_usuario_adm');
  console.log(resAdmins);

  await connection.end();
  console.log('Seed finalizado com sucesso!');
}

seed().catch(err => {
  console.error('Erro no seed:', err);
  process.exit(1);
});
