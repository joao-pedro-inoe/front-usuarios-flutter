# 🚀 Projeto Front-end - Desenvolvimento Móvel

Este repositório contém a implementação do **Front-end** desenvolvido para a disciplina de **OPT-120 Desenvolvimento Móvel**. A aplicação foi construída em **Flutter Web** e consome uma API RESTful responsável pelo gerenciamento de usuários.

## 📌 Sobre o Projeto

O objetivo principal deste projeto é fornecer uma interface visual moderna e interativa para o gerenciamento de usuários. A aplicação se comunica com um back-end para realizar operações de CRUD (Create, Read, Update, Delete).

### 🛠️ Tecnologias Principais
* **Framework:** Flutter Web
* **Linguagem:** Dart
* **Consumo de API:** HTTP (requisições REST)
* **Finalidade:** Interface para interação com a API de usuários
* **Arquitetura:** Cliente Web consumindo API RESTful

---

## 🏗️ Arquitetura e Integração

O projeto segue o fluxo de comunicação padrão para aplicações web/mobile modernas:

1. O **Frontend (Flutter Web)** realiza requisições HTTP (GET, POST, PUT, DELETE).
2. O **Back-end (Node.js + Express)** processa as regras de negócio.
3. Os dados são persistidos no **PostgreSQL**.
4. A resposta retorna ao front-end para atualização da interface.

---

## 🛠️ Pré-requisitos

Antes de começar, você precisará ter instalado em sua máquina:

* [Flutter](https://docs.flutter.dev/get-started/install) (SDK atualizado)
* Navegador (Chrome recomendado)
* Backend rodando (API de usuários)

---

## 🚀 Como rodar o projeto

### 1. Clonar o repositório

```bash
git clone https://github.com/joao-pedro-inoe/front-usuarios-flutter.git
cd front-usuarios-flutter
```

### 2. Instalar dependências

```bash
flutter pub get
```
### 3. Executar a aplicação

 ```bash
 flutter run -d web-server
```