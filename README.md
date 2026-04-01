# Front-End: Gestão de Usuários (Flutter Web)

Este repositório contém o código-fonte da aplicação front-end desenvolvida em **Flutter (focada na plataforma Web)**. O projeto tem como objetivo principal consumir uma API RESTful local, fornecendo uma interface gráfica interativa para a gestão de usuários.

## 🚀 Funcionalidades (CRUD)

A aplicação gerencia o estado da interface e realiza requisições HTTP (`http` package) para entregar as seguintes funcionalidades:
- **C (Create):** Tela de formulário para cadastro de novos usuários (POST).
- **R (Read):** Listagem dinâmica dos usuários cadastrados no banco de dados (GET).
- **U (Update):** Tela de edição preenchida dinamicamente para atualizar dados (PUT).
- **D (Delete):** Exclusão de registros diretamente da lista, com diálogo de confirmação (DELETE).
- **Tratamento de Erros:** Feedback visual (SnackBars) para sucesso, falhas de validação e erros de conexão (ex: servidor offline).

## 📂 Estrutura de Arquivos

O código-fonte principal está centralizado no diretório `lib/`:

```text
front_usuarios/
├── lib/
│   ├── main.dart             # Ponto de entrada (Menu Principal e rotas)
│   ├── tela_cadastro.dart    # Lógica e layout do formulário de criação
│   ├── tela_listagem.dart    # Lógica de listagem e botões de ação (FutureBuilder)
│   └── tela_edicao.dart      # Lógica e layout do formulário de atualização
├── pubspec.yaml              # Configurações do projeto e dependências (pacote http)
└── README.md                 # Documentação do projeto
```

## ⚙️ Como executar o projeto

### Pré-requisitos

    Flutter SDK instalado e configurado para compilação Web.

    A API de Back-End (Node.js/PostgreSQL) deve estar rodando localmente na porta 3000 (disponível em http://localhost:3000/usuarios).

    O Back-End precisa estar com a política de CORS (Cross-Origin Resource Sharing) ativada.

### Passo a Passo

    Abra o terminal e navegue até a pasta raiz deste projeto 

    Inicie a aplicação utilizando o servidor web local do Flutter: 

    ```bash
    flutter run -d web-server
    ```
    O terminal fornecerá um endereço local (ex: http://localhost:35421). Copie e cole este link no seu navegador.