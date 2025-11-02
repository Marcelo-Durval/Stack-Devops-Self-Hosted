# #Agente de IA para Estudos Bíblicos via WhatsApp📖 

1. Descrição:
    "Este projeto é uma automação que implementa um agente de Inteligência Artificial avançado para estudos bíblicos, 
    acessível diretamente pelo WhatsApp. O objetivo é fornecer análises aprofundadas e multifacetadas sobre dúvidas bíblicas, 
    permitindo que o usuário explore temas sob diversas perspectivas teológicas e históricas.
    Ao receber uma pergunta, o agente primeiro busca entender qual linha de pensamento o usuário deseja seguir 
    (Catolicismo, Protestantismo, Espiritismo, etc.) para, então, fornecer uma resposta rica e contextualizada, 
    incluindo citações de autores relevantes, contexto histórico, linguístico e arqueológico.

2. Funções Principais:
    "O agente foi projetado para oferecer as seguintes funcionalidades:
        Contexto Histórico e Linguístico: Explica o significado de passagens e temas considerando o contexto cultural da época, a língua original (hebraico/grego) e descobertas arqueológicas.
        Múltiplas Perspectivas Teológicas: Apresenta respostas alinhadas a diferentes linhas de crença (Catolicismo, Protestantismo, Espiritismo, entre outras), conforme a escolha do usuário.
        Citações de Autores: Enriquece as respostas com citações de teólogos, historiadores e estudiosos relevantes para a linha de pensamento selecionada.
        Respostas em Áudio: Oferece a opção de gerar e enviar a resposta em formato de áudio/podcast, ideal para consumo em trânsito.
        Geração de Sermões: Cria um esboço de sermão ou pregação baseado no tema ou passagem bíblica indicada pelo usuário.
        Aplicação Contemporânea: Conecta os ensinamentos bíblicos com a realidade atual, trazendo relevância e aplicação prática para o dia a dia, com citações e exemplos modernos.
    
3. Arquitetura e Ferramentas:
    Este projeto é construído sobre uma stack de ferramentas modernas, focada em automação e auto-hospedagem (self-hosting).
    Ferramentas:
        Função:
            N8N🧠 Orquestração e IA: Responsável pelo fluxo de trabalho, automações, treinamento e lógica principal da IA.
            Waha (WhatsApp API)📱 Interface com o Usuário: Serve como a ponte para receber as perguntas e enviar as respostas via WhatsApp.
            Supabase🐘 Banco de Dados: Utilizado para armazenar dados de interações, logs, e possivelmente material de estudo (PostgreSQL).
            Coolify🚀 Gerenciador de Ambiente: Plataforma de PaaS (Platform-as-a-Service) que gerencia o deploy e o ciclo de vida de todas as aplicações no servidor.
            Portainer🐳 Gerenciador de Containers: Administra os containers Docker e as redes internas, garantindo que os serviços se comuniquem de forma eficiente.
            GitHub🔄 Controle de Versão: Utilizado para o versionamento do código e workflows de atualização (CI/CD).
            
4. Instalação e Configuração(Esta seção deve ser detalhada com os passos específicos do seu projeto)
    Pré-requisitos:
        Um servidor (VPS ou local) com Docker e Docker Compose instalados.
        Contas criadas no Supabase e GitHub.
        Domínio configurado apontando para o servidor (recomendado para Coolify e certificados SSL).
        Clone o repositório:Bashgit clone https://github.com/seu-usuario/seu-repositorio.git
        
        ```bash
        cd seu-repositorio
        ```
    
    Configure as variáveis de ambiente:
        Crie um arquivo .env a partir do .env.example.
        Preencha as chaves de API para o N8N, Supabase e Waha.
        Deploy com Coolify:Adicione este repositório como uma nova aplicação no Coolify.
        Configure os serviços (N8N, Waha) apontando para os respectivos Dockerfiles ou imagens.
        Configure a instância do Supabase e conecte as credenciais.
        Configure o Workflow no N8N:Importe o fluxo de trabalho (workflow.json) para a sua instância do N8N.
        Configure o webhook para receber mensagens do Waha.
    
5. Como Usar
    Após a configuração, basta enviar uma mensagem para o número de WhatsApp conectado ao Waha.
    Envie sua dúvida bíblica (ex: "Qual o significado da parábola do filho pródigo?").
    O agente responderá pedindo para você escolher uma linha de interpretação.
    Selecione a opção desejada.
    Receba a resposta completa com contexto, citações e aplicação prática.