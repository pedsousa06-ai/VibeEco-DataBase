# 🗄️ VibeEco-DataBase

<p align="center">
  <strong>Banco de Dados da plataforma VibeEco</strong>
</p>

---

## 📌 Sobre este repositório

Este repositório contém a **modelagem e a implementação do banco de dados** do VibeEco. Ele é a base de dados compartilhada pelas duas APIs da plataforma: a **API de Usuários** e a **API Administrativa**.

**Responsável:** Ryller Feitosa — [GitHub](https://github.com/ryllerfeitosadba)

---

## 🏗️ Posição na arquitetura

```mermaid
flowchart TD
    DB[("🗄️ Banco de Dados<br/>(este repositório)")]
    APIU["⚙️ API de Usuários"]
    APIA["⚙️ API Admin"]
    DB --- APIU
    DB --- APIA
```

---

## 🎯 Responsabilidades

- Modelo conceitual;
- Modelo lógico;
- Modelo físico;
- Criação das tabelas;
- Chaves primárias;
- Chaves estrangeiras;
- Relacionamentos;
- Restrições;
- Scripts do banco;
- Validação da estrutura.

---

## 🔄 Etapas de desenvolvimento

```text
Modelo Conceitual
       ↓
Modelo Lógico
       ↓
Modelo Físico
       ↓
Implementação
       ↓
Validação
```

### Modelo Conceitual

- Levantamento das entidades;
- Definição dos atributos;
- Definição dos relacionamentos;
- Definição das cardinalidades;
- Revisão do modelo.

### Modelo Lógico

- Transformação das entidades em tabelas;
- Definição das chaves primárias e estrangeiras;
- Definição dos atributos e tipos de dados;
- Revisão do modelo.

### Modelo Físico

- Criação do banco e das tabelas;
- Criação das chaves, restrições e relacionamentos;
- Configuração do banco.

---

## 🗂️ Domínios de dados

O banco deve dar suporte às funcionalidades da plataforma:

- Usuários e administradores (autenticação, permissões);
- Perfil e histórico de atividades;
- Feed, publicações, curtidas e comentários;
- Missões e desafios;
- Conteúdos educativos e quiz;
- Gamificação: XP, níveis, Moedas Verdes, conquistas e ranking;
- Recompensas;
- Notificações.

<!-- TODO: listar as tabelas reais assim que o modelo físico estiver fechado -->

---

## 📁 Estrutura do repositório

<!-- TODO: ajustar conforme a estrutura real -->

```text
VibeEco-DataBase
│
├── 📁 modelagem      # Modelos conceitual e lógico (diagramas)
├── 📁 scripts        # Scripts de criação das tabelas, chaves e restrições
├── 📁 dados          # Dados iniciais (seeds), se houver
└── 📄 README.md
```

---

## ⚙️ Como executar

<!-- TODO: informar o SGBD utilizado e a versão -->

1. Instale o SGBD utilizado pelo projeto: `<SGBD e versão>`;
2. Crie o banco de dados: `<nome do banco>`;
3. Execute os scripts de criação da pasta `scripts`, na ordem indicada;
4. (Opcional) Execute os scripts de dados iniciais;
5. Valide a estrutura criada.

---

## 🧪 Testes e validação

- Testes da estrutura;
- Testes dos relacionamentos;
- Testes das restrições;
- Validação dos dados.

---

## 🔐 Segurança

- Não versionar credenciais nem dados reais de usuários;
- Usar usuários de banco com o mínimo de permissões necessárias;
- Armazenar senhas apenas de forma protegida (hash).

---

## 📊 Status

🚧 **Em desenvolvimento**

- [ ] Modelo conceitual
- [ ] Modelo lógico
- [ ] Modelo físico
- [ ] Implementação
- [ ] Validação

---

## 🌱 Sobre o VibeEco

O **VibeEco** é uma plataforma digital desenvolvida pela **TechProton** para promover a conscientização e o engajamento em sustentabilidade, por meio de conteúdos educativos, missões, desafios, gamificação e interação social.

🔗 **Repositório principal:** [VibeEco](https://github.com/pedsousa06-ai/VibeEco)

### 📦 Repositórios do projeto

| Área | Repositório | Responsável |
|------|-------------|-------------|
| 🗄️ Banco de Dados | [VibeEco-DataBase](https://github.com/pedsousa06-ai/VibeEco-DataBase) | Ryller Feitosa |
| ⚙️ Back-end Usuários | [VibeEco-Back-End-Users](https://github.com/pedsousa06-ai/VibeEco-Back-End-Users) | Lucas Kolle |
| ⚙️ Back-end Administrativo | [VibeEco-Back-End-Adm](https://github.com/pedsousa06-ai/VibeEco-Back-End-Adm) | Lucas Kolle |
| 🖥️ Front-end Usuários | [VibeEco-Front-End-Users](https://github.com/pedsousa06-ai/VibeEco-Front-End-Users) | Gabriel Sousa |
| 🖥️ Front-end Administrativo | [VibeEco-Front-End-Adm](https://github.com/pedsousa06-ai/VibeEco-Front-End-Adm) | Gabriel Sousa |
| 📱 Mobile | [VibeEco-Mobile](https://github.com/pedsousa06-ai/VibeEco-Mobile) | Pedro Sousa |

---

## 📄 Licença

Este projeto foi desenvolvido pela equipe TechProton como parte do projeto VibeEco. Informações sobre licenciamento e distribuição deverão ser definidas pela equipe responsável pelo projeto.

## 👨‍💻 TechProton

| | |
|---|---|
| **Projeto** | VibeEco |
| **Empresa** | TechProton |
| **Categoria** | Tecnologia • Sustentabilidade • Educação |
| **Status** | Em desenvolvimento |
| **Início** | 10/08/2026 |

---

## ▶️ Como subir o VibeEco inteiro com dados reais

**1. Banco (escolha um):**
- Docker: `docker compose up -d` (MySQL 8 na porta 3306, usuário `root`, senha `bcd127`, já com todos os scripts).
- MySQL instalado: `cd Scripts` e `mysql -u root -p --default-character-set=utf8mb4 < rodar_tudo.sql`.

Ordem dos scripts: `Creates` → `Inserts` → `Procedures de inserts` → `TriggersAdministrador` → `TriggersUsers` → `SelectsUSER` → `migracao_perfil` → `migracao_adm_sincronizar` → `migracao_auth_usuario`. As demais `migracao_*.sql` só servem para bancos antigos (o `Creates.sql` atual já inclui tudo).

**2. APIs** (cada uma: `npm install`, copiar `.env.example` para `.env`, `npm start`):

| Projeto | Porta | Endereço base |
|---|---|---|
| VibeEco-Back-End-Users | 8080 | `http://localhost:8080/v1/senai/vibeEco` |
| VibeEco-Back-End-Adm | 8081 | `http://localhost:8081/v1/vibeEco/administrador` |

**3. Fronts** (`npm install` e `npm run dev`): `VibeEco-Front-End-Users` usa a API 8080; `VibeEco-Front-End-Adm` usa a API 8081 (`VITE_API_URL` no `.env`).

**4. App Android:** emulador acessa a API de usuários em `http://10.0.2.2:8080` (já configurado em `AppConfig.kt`).

**Logins de exemplo (Inserts.sql):** painel adm `admin1@vibeeco.com` / `admin123`; usuário comum `lucas.oliveira@email.com` / `senha123` (outros em `Inserts.sql`).

**Perfil de demonstração (apresentação do TCC):** rode `Scripts/perfil_demonstracao.sql` depois do banco base. Cria a usuária `ana.beatriz@vibeeco.com` / senha `Vibe@2026` (ou matrícula `2024001234`), nível 2 com 795 XP, 270 moedas, ofensiva de 12 dias, missões concluídas/em andamento/disponível, conteúdos lidos, desafios, posts com curtidas e comentários, conquistas, notificações e uma recompensa resgatada. Pode ser rodado várias vezes (recria a demonstração do zero sem mexer nos outros usuários).


## Conteúdos extras

`Scripts/conteudos_extras.sql` adiciona 9 conteúdos educativos (texto completo, XP, tempo de leitura, categoria e imagem) e corrige as imagens dos 3 conteúdos originais. É idempotente. As imagens usam loremflickr.com; para fotos definitivas, atualize a coluna `img`.
