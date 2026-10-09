-- ***** BANCO DE DADOS VIBEECO *****

create database if not exists db_vibeEco_2026;
use db_vibeEco_2026;


-- ============================================================
-- TABELAS DE SUPORTE / DOMÍNIO
-- ============================================================

create table tbl_escolaridade(
    id int not null primary key auto_increment,
    nome varchar(75) not null
);

create table tbl_status(
    id int not null primary key auto_increment,
    is_active boolean not null default true
);

create table tbl_nivel_acesso(
    id int not null primary key auto_increment,
    nivel varchar(25) not null
);

create table tbl_level_user(
    id int not null primary key auto_increment,
    nome varchar(40) not null,
    numero_level int not null,
    xp_necessario int not null
);

create table tbl_instituicao(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text
);

create table tbl_categoria(
    id int not null primary key auto_increment,
    nome varchar(50) not null
);

create table tbl_dificuldade(
    id int not null primary key auto_increment,
    nome varchar(50) not null
);


-- ============================================================
-- USUÁRIO
-- ============================================================

create table tbl_usuario(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    email varchar(255) not null unique,
    senha varchar(255) not null,
    foto text,
    total_xp int default 0,
    coins int default 0,
    data_ultimo_acesso datetime,
    id_escolaridade int not null,
    id_status int not null,
    id_instituicao int not null,
    id_nivel_acesso int not null,
    id_level int not null,

    constraint FK_ESCOLARIDADE_USUARIO
        foreign key (id_escolaridade)
        references tbl_escolaridade(id),

    constraint FK_STATUS_USUARIO
        foreign key (id_status)
        references tbl_status(id),

    constraint FK_INSTITUICAO_USUARIO
        foreign key (id_instituicao)
        references tbl_instituicao(id),

    constraint FK_NIVEL_ACESSO_USUARIO
        foreign key (id_nivel_acesso)
        references tbl_nivel_acesso(id),

    constraint FK_LEVEL_USUARIO
        foreign key (id_level)
        references tbl_level_user(id)
);


create table tbl_usuario_adm(
    id int not null primary key auto_increment,
    email varchar(255) not null,
    senha varchar(255) not null,
    id_nivel_acesso int not null,

    constraint FK_NIVEL_ACESSO_USUARIO_ADM
        foreign key (id_nivel_acesso)
        references tbl_nivel_acesso(id)
);


-- ============================================================
-- OFENSIVA
-- ============================================================

create table tbl_ofensiva(
    id int not null primary key auto_increment,
    id_usuario int not null,
    data_ofensiva date not null,
    concluido boolean not null default false,

    constraint FK_USUARIO_OFENSIVA
        foreign key (id_usuario)
        references tbl_usuario(id),

    -- Não permite cadastrar mais de uma ofensiva
    -- para o mesmo usuário na mesma data
    constraint UQ_USUARIO_DATA_OFENSIVA
        unique (id_usuario, data_ofensiva)
);


-- ============================================================
-- ANEXOS
-- ============================================================

create table tbl_anexo(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    endereco_url text not null
);


-- ============================================================
-- MISSÕES, DESAFIOS E CONTEÚDOS
-- ============================================================

create table tbl_missao(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    coins int not null,
    total_xp_missao int not null,
    data_inicio date not null,
    data_termino date not null,
    id_dificuldade int not null,

    constraint FK_DIFICULDADE_MISSAO
        foreign key (id_dificuldade)
        references tbl_dificuldade(id)
);


create table tbl_desafio(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    super_coins int not null,
    data_inicio date,
    data_termino date,
    id_dificuldade int not null,

    constraint FK_DIFICULDADE_DESAFIO
        foreign key (id_dificuldade)
        references tbl_dificuldade(id)
);


create table tbl_conteudo_educativo(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    img text not null
);


create table tbl_recompensa(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    valor int not null,
    data_inicio date,
    data_termino date
);


create table tbl_conquista(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    descricao text,
    img text not null
);


-- ============================================================
-- RELACIONAMENTOS DE MISSÃO, DESAFIO E CONTEÚDO
-- ============================================================

create table tbl_missao_categoria(
    id int not null primary key auto_increment,
    id_missao int not null,
    id_categoria int not null,

    constraint FK_MISSAO_MISSAOCATEGORIA
        foreign key (id_missao)
        references tbl_missao(id),

    constraint FK_CATEGORIA_MISSAOCATEGORIA
        foreign key (id_categoria)
        references tbl_categoria(id)
);


create table tbl_desafio_categoria(
    id int not null primary key auto_increment,
    id_desafio int not null,
    id_categoria int not null,

    constraint FK_DESAFIO_DESAFIOCATEGORIA
        foreign key (id_desafio)
        references tbl_desafio(id),

    constraint FK_CATEGORIA_DESAFIOCATEGORIA
        foreign key (id_categoria)
        references tbl_categoria(id)
);


create table tbl_conteudo_educativo_categoria(
    id int not null primary key auto_increment,
    id_conteudo_educativo int not null,
    id_categoria int not null,

    constraint FK_CONTEUDOEDUCATIVO_CONTEUDOEDUCATIVOCATEGORIA
        foreign key (id_conteudo_educativo)
        references tbl_conteudo_educativo(id),

    constraint FK_CATEGORIA_CONTEUDOEDUCATIVOCATEGORIA
        foreign key (id_categoria)
        references tbl_categoria(id)
);


-- ============================================================
-- FEED E INTERAÇÕES SOCIAIS
-- ============================================================

create table tbl_post(
    id int not null primary key auto_increment,
    id_usuario int not null,
    descricao text not null,
    data_publicacao datetime default current_timestamp,

    constraint FK_USUARIO_POST
        foreign key (id_usuario)
        references tbl_usuario(id)
);


create table tbl_post_anexo(
    id int not null primary key auto_increment,
    id_post int not null,
    id_anexo int not null,

    constraint FK_POST_ANEXO_POST
        foreign key (id_post)
        references tbl_post(id),

    constraint FK_POST_ANEXO_ANEXO
        foreign key (id_anexo)
        references tbl_anexo(id)
);


create table tbl_post_curtida(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_post int not null,
    data_curtida datetime default current_timestamp,

    constraint FK_CURTIDA_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_CURTIDA_POST
        foreign key (id_post)
        references tbl_post(id)
);


create table tbl_post_comentario(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_post int not null,
    comentario text not null,
    data_comentario datetime default current_timestamp,

    constraint FK_COMENTARIO_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_COMENTARIO_POST
        foreign key (id_post)
        references tbl_post(id)
);


-- ============================================================
-- PREMIAÇÃO
-- ============================================================

create table tbl_premiacao(
    id int not null primary key auto_increment,
    nome varchar(20) not null,
    descricao text,
    codigo_rastreio varchar(50) not null,
    motivo_premiacao text
);


-- ============================================================
-- NOTIFICAÇÕES
-- ============================================================

create table tbl_notificacao(
    id int not null primary key auto_increment,
    id_usuario int not null,
    titulo varchar(100) not null,
    mensagem text not null,
    lida boolean default false,
    data_criacao datetime default current_timestamp,

    constraint FK_NOTIFICACAO_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id)
);


-- ============================================================
-- TABELAS DE ASSOCIAÇÃO COM CONTROLE DE ESTADO
-- ============================================================

create table tbl_usuario_missao(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_missao int not null,
    status enum('EM_ANDAMENTO', 'CONCLUIDA', 'CANCELADA')
        default 'EM_ANDAMENTO',
    data_conclusao datetime,

    constraint FK_UM_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_UM_MISSAO
        foreign key (id_missao)
        references tbl_missao(id)
);


create table tbl_usuario_premiacao(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_premiacao int not null,

    constraint FK_USUARIO_USUARIOPREMIACAO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_PREMIACAO_USUARIOPREMIACAO
        foreign key (id_premiacao)
        references tbl_premiacao(id)
);


create table tbl_usuario_desafio(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_desafio int not null,
    status enum('EM_ANDAMENTO', 'CONCLUIDO')
        default 'EM_ANDAMENTO',
    data_conclusao datetime,

    constraint FK_UD_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_UD_DESAFIO
        foreign key (id_desafio)
        references tbl_desafio(id)
);


create table tbl_usuario_recompensa(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_recompensa int not null,
    data_resgate datetime default current_timestamp,
    codigo_resgate varchar(50),

    constraint FK_UR_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_UR_RECOMPENSA
        foreign key (id_recompensa)
        references tbl_recompensa(id)
);


create table tbl_usuario_conteudo_educativo(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_conteudo_educativo int not null,
    concluido boolean default false,
    data_acesso datetime default current_timestamp,

    constraint FK_UCE_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_UCE_CONTEUDO
        foreign key (id_conteudo_educativo)
        references tbl_conteudo_educativo(id)
);


create table tbl_usuario_conquista(
    id int not null primary key auto_increment,
    id_usuario int not null,
    id_conquista int not null,
    data_conquista datetime default current_timestamp,

    constraint FK_UC_USUARIO
        foreign key (id_usuario)
        references tbl_usuario(id),

    constraint FK_UC_CONQUISTA
        foreign key (id_conquista)
        references tbl_conquista(id)
);


-- ============================================================
-- OFENSIVA + MISSÃO + CONTEÚDO EDUCATIVO
-- ============================================================

create table tbl_usuario_missao_usuario_conteudo_educativo_ofensiva(
    id int not null primary key auto_increment,
    id_usuario_missao int null,
    id_usuario_conteudo_educativo int null,
    id_ofensiva int not null,

    constraint FK_USUARIOMISSAO_USUARIOMISSAO_OFENSIVA
        foreign key (id_usuario_missao)
        references tbl_usuario_missao(id),

    constraint FK_USUARIOCONTEUDOEDUCATIVO_USUARIOCONTEUDOEDUCATIVO_OFENSIVA
        foreign key (id_usuario_conteudo_educativo)
        references tbl_usuario_conteudo_educativo(id),

    constraint FK_OFENSIVA_USUARIOMISSAO_USUARIOCONTEUDOEDUCATIVO_OFENSIVA
        foreign key (id_ofensiva)
        references tbl_ofensiva(id)
);


-- ============================================================
-- CONTEÚDO EDUCATIVO + ANEXO
-- ============================================================

create table tbl_conteudo_educativo_anexo(
    id int not null primary key auto_increment,
    id_conteudo_educativo int not null,
    id_anexo int not null,

    constraint FK_CONTEUDOEDUCATIVO_CONTEUDOEDUCATIVOANEXO
        foreign key (id_conteudo_educativo)
        references tbl_conteudo_educativo(id),

    constraint FK_ANEXO_CONTEUDOEDUCATIVOANEXO
        foreign key (id_anexo)
        references tbl_anexo(id)
);


-- ============================================================
-- RECOMPENSA + ANEXO
-- ============================================================

create table tbl_recompensa_anexo(
    id int not null primary key auto_increment,
    id_recompensa int not null,
    id_anexo int not null,

    constraint FK_RECOMPENSA_RECOMPENSAANEXO
        foreign key (id_recompensa)
        references tbl_recompensa(id),

    constraint FK_ANEXO_RECOMPENSAANEXO
        foreign key (id_anexo)
        references tbl_anexo(id)
);


-- ============================================================
-- VERIFICAR TABELAS
-- ============================================================

show tables;
desc tbl_desafio;