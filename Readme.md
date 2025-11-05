# Stack de Desenvolvimento Self-Hosted (N8N, Supabase, Appsmith, WAHA, Portainer)

Este é um repositório-base (boilerplate) para um ambiente de desenvolvimento completo e auto-hospedado, gerenciado inteiramente via Docker Compose.

O foco é fornecer uma fundação robusta para automação (N8N), APIs de WhatsApp (WAHA), UIs de low-code (Appsmith) e **gerenciamento de contêineres (Portainer)**, todos operando de forma eficiente sobre um único banco de dados PostgreSQL.

## 🛠️ Tecnologias Inclusas

* **Orquestração:** `Docker Compose`
* **Gerenciamento de Contêineres:** **`Portainer`**
* **Banco de Dados Central:** `PostgreSQL` (Baseado na imagem do Supabase)
* **Automação de Workflows:** `N8N`
* **UI Low-Code:** `Appsmith`
* **API de WhatsApp:** `WAHA` (WhatsApp HTTP API)
* **Versionamento:** `Git` & `GitHub`

## 🏛️ Arquitetura

Este stack é projetado para eficiência e simplicidade:

1.  **Banco de Dados Unificado:** Todos os serviços (N8N, Appsmith) são configurados para usar um **único servidor PostgreSQL** (`supabase-db`), mas em bancos de dados (`n8n_db`, `appsmith_db`) e com usuários separados para maior segurança.
2.  **Inicialização Automática:** Na primeira vez que o stack é iniciado, o script `supabase/init-db.sh` é executado automaticamente. Ele lê as variáveis do seu arquivo `.env` e cria os bancos de dados e usuários necessários para cada serviço.
3.  **Persistência de Dados:** Os dados de cada serviço são armazenados em volumes Docker, que são gerenciados pelo Docker e ignorados pelo Git (via `.gitignore`).

## 🚀 Guia de Instalação (Ambiente Local)

Este guia simula um novo desenvolvedor configurando o projeto do zero.

### Pré-requisitos

* [Git](https://git-scm.com/downloads)
* [Docker](https://www.docker.com/products/docker-desktop/)
* [Docker Compose](https://docs.docker.com/compose/install/) (geralmente já vem com o Docker Desktop)

### Passo a Passo

1.  **Clone o Repositório**
    (Substitua `seu-usuario` pelo seu nome de usuário do GitHub)
    ```sh
    git clone [https://github.com/seu-usuario/Stack-Devops-Self-Hosted.git](https://github.com/seu-usuario/Stack-Devops-Self-Hosted.git)
    cd Stack-Devops-Self-Hosted
    ```

2.  **Crie o Arquivo de Segredos (.env)**
    Nós usaremos o template `.env.exemple` (ou `.env.example`) para criar nosso arquivo `.env` local. Este arquivo **nunca** é enviado para o GitHub.
    ```sh
    cp .env.exemple .env
    ```

3.  **Preencha as Variáveis de Ambiente**
    Abra o arquivo `.env` com seu editor de código (VSCode, etc.).
    * **Revise as Portas:** Verifique as portas (ex: `N8N_PORT`, `POSTGRES_PORT`) e ajuste-as se já estiverem em uso na sua máquina.
    * **Preencha os Segredos:** Preencha **todas** as senhas (ex: `POSTGRES_PASSWORD`). Para segurança, use senhas fortes e diferentes para cada serviço.

4.  **Dê Permissão de Execução ao Script (Linux/Mac)**
    Precisamos garantir que nosso script de inicialização do banco possa ser executado.
    ```sh
    chmod +x supabase/init-db.sh
    ```

5.  **Suba o Stack!**
    Este comando irá baixar todas as imagens e iniciar todos os contêineres em segundo plano (`-d`).
    ```sh
    docker compose up -d
    ```

Na primeira vez, aguarde 1-2 minutos. O Postgres precisa rodar o script de inicialização e o N8N/Appsmith precisam criar suas tabelas internas.

## 🖥️ Acessando os Serviços (Localhost)

As portas são definidas no seu arquivo `.env`. Os links abaixo assumem os valores padrão (sugeridos no `.env.exemple`).

* **Portainer (Gerenciamento Docker):** **`http://localhost:${PORTAINER_PORT}`** (Padrão: 9000)
    * *(Na primeira visita, ele solicitará a criação de uma conta de administrador.)*
* **N8N:** `http://localhost:${N8N_PORT}` (Padrão: 5678)
* **Appsmith:** `http://localhost:${APPSMITH_PORT}` (Padrão: 8081)
* **WAHA (Swagger UI):** `http://localhost:${WAHA_PORT}` (Padrão: 3000)
* **Banco de Dados (PostgreSQL):**
    * **Host:** `localhost`
    * **Porta:** `${POSTGRES_PORT}` (Padrão: 5432)
    * **Usuário:** `postgres`
    * **Senha:** (A que você definiu em `POSTGRES_PASSWORD`)

## 🔁 Workflow de Desenvolvimento

### Gerenciando Fluxos do N8N

1.  Desenvolva e teste seus fluxos no N8N local (acessando a porta que você definiu, ex: `http://localhost:5678`).
2.  Quando um fluxo estiver pronto, exporte-o como JSON (Menu > Export > JSON).
3.  Salve este arquivo `.json` na pasta `n8n-data/workflows/`.
4.  Faça o commit e push do novo arquivo JSON para o GitHub.
    ```sh
    git add n8n-data/workflows/meu-novo-fluxo.json
    git commit -m "Adiciona novo fluxo de boas-vindas"
    git push
    ```
    Isso mantém seus fluxos versionados e seguros.

### Gerenciando o Banco de Dados (Migrações)

Para adicionar ou alterar tabelas (ex: para o Appsmith), o ideal é usar migrações do Supabase:

1.  Instale a [Supabase CLI](https://supabase.com/docs/guides/cli).
2.  Crie uma nova migração:
    ```sh
    supabase migration new nome_da_sua_migracao
    ```
3.  Edite o novo arquivo `.sql` que foi criado dentro da pasta `supabase/migrations/`.
4.  Aplique a migração no seu banco local:
    ```sh
    supabase db push
    ```
5.  Faça o commit e push do novo arquivo de migração para o GitHub.

## ☁️ Deploy em Produção (Coolify)

O objetivo deste repositório é ser 100% compatível com o **Coolify** (ou qualquer plataforma GitOps).

1.  Certifique-se de que seu projeto (com o `docker-compose.yml` e o `init-db.sh`) esteja no GitHub.
2.  Na interface do seu Coolify, crie um "New Resource".
3.  Escolha "From a Public or Private Repository" e aponte para este repositório.
4.  O Coolify vai detectar automaticamente o `docker-compose.yml`.
5.  Na aba **"Secrets"** do seu recurso no Coolify, copie e cole **todas** as variáveis do seu arquivo `.env` local (incluindo as portas e as senhas).
6.  Clique em **"Deploy"**.

O Coolify irá rodar os mesmos passos que você rodou localmente, subindo todo o stack no seu servidor.