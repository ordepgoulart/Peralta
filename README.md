# Peralta

Sistema web para registro, acompanhamento e gerenciamento de denúncias urbanas, permitindo que cidadãos comuniquem problemas da cidade aos órgãos competentes de forma rápida, estruturada e centralizada. A solução combina um frontend em Vue 3 com uma API REST em Spring Boot, autenticação por token JWT e persistência em banco de dados relacional, conforme a estrutura de arquivos enviada e o enunciado funcional do projeto.[1]

## Visão geral

O projeto Peralta implementa a proposta do aplicativo **Ativo e Operante!**, oferecendo um ambiente em que usuários autenticados podem cadastrar denúncias com título, descrição, data, grau de urgência, foto opcional, órgão responsável e tipo de problema.[1] A aplicação também possui um módulo administrativo para gerenciar órgãos, tipos de ocorrência, denúncias e feedbacks, com diferenciação de acesso entre cidadão e administrador.[1]

## Objetivos do sistema

- Facilitar a comunicação entre cidadão e poder público por meio do envio estruturado de denúncias urbanas.[1]
- Centralizar o cadastro e a consulta de órgãos competentes e tipos de problemas.[1]
- Permitir acompanhamento das denúncias por parte do usuário autenticado, incluindo visualização de feedback.[1]
- Disponibilizar ao administrador ferramentas de gestão e moderação do fluxo de denúncias.[1]

## Funcionalidades principais

### Área do cidadão

- Cadastro de conta com dados como CPF, e-mail e senha.[1]
- Login com autenticação baseada em token.[1]
- Registro de denúncia com título, descrição, data, urgência, foto opcional, órgão e tipo de problema.[1]
- Consulta das próprias denúncias enviadas.[1]
- Visualização de feedback associado à denúncia.[1]

### Área administrativa

- CRUD completo de órgãos competentes.[1]
- CRUD completo de tipos de problema.[1]
- Listagem e visualização das denúncias cadastradas.[1]
- Exclusão de denúncias.[1]
- Registro de um único feedback por denúncia.[1]

## Arquitetura do projeto

A aplicação está organizada em duas camadas principais: `frontend` e `backend`, além de um script SQL da base de dados (`peraltadb.sql`) e um arquivo de licença no diretório raiz.[1] Essa separação evidencia uma arquitetura cliente-servidor, com interface desacoplada da API e responsabilidades distribuídas entre apresentação, regras de negócio, segurança e persistência.[1]

### Frontend

O frontend foi desenvolvido com **Vue 3** e **Vite**, usando uma estrutura baseada em páginas, componentes reutilizáveis, serviços e utilitários, conforme o `package.json` e a árvore de arquivos compartilhada.[1] Entre as dependências declaradas estão `axios` para comunicação HTTP, `vue-router` para navegação, `@meforma/vue-toaster` para notificações e bibliotecas de ícones como `bootstrap-icons-vue`, `lucide-vue-next` e `primeicons`.[1]

#### Estrutura de destaque do frontend

- `src/pages/`: telas principais como login, área do usuário e painéis administrativos.[1]
- `src/components/`: componentes reutilizáveis de interface, formulários, tabelas, cards, modais e layout.[1]
- `src/service/api.js`: camada de integração com a API backend.[1]
- `src/utils/Validator.js` e `src/utils/Masker.js`: apoio a validação e máscaras de entrada.[1]

### Backend

O backend foi desenvolvido com **Spring Boot** e Maven, com separação clara entre entidades, repositórios, serviços, controladores REST, DTOs e classes de segurança.[1] A presença de `JWTTokenProvider`, `AccessFilter` e `FilterConfiguration` indica autenticação baseada em JWT e controle de acesso por filtro de requisição.[1]

#### Estrutura de destaque do backend

- `entities/`: modelagem de domínio com classes como `Denuncia`, `Usuario`, `Tipo`, `Orgao`, `Feedback`, `Foto` e `Erro`.[1]
- `repositories/`: acesso a dados via repositórios JPA para os principais agregados do sistema.[1]
- `services/`: regras de negócio relacionadas a denúncia, usuário, órgão, tipo e feedback.[1]
- `restcontrollers/`: controladores separados para convidados, usuários autenticados e administradores.[1]
- `DTO/`: objetos de transferência para operações como login e transporte de dados.[1]

## Tecnologias utilizadas

| Camada | Tecnologias identificadas |
|---|---|
| Frontend | Vue 3, Vite, Axios, Vue Router, Vue Toaster, Bootstrap Icons Vue, Lucide Vue, PrimeIcons [1] |
| Backend | Java, Spring Boot, Spring REST, Maven, JPA/Repositories, JWT [1] |
| Dados | Banco de dados relacional e script `peraltadb.sql` [1] |
| Uploads | Armazenamento de arquivos enviados em `backend/uploads` [1] |

## Fluxo de uso

1. O usuário acessa a aplicação pela tela inicial e realiza cadastro ou autenticação.[1]
2. Após o login, o cidadão pode registrar uma nova denúncia, escolhendo órgão e tipo carregados a partir da API.[1]
3. A denúncia é enviada ao backend, persistida no banco e pode incluir foto opcional.[1]
4. O administrador acessa o módulo administrativo com permissões ampliadas para manter cadastros e moderar denúncias.[1]
5. O cidadão pode acompanhar o histórico das denúncias e visualizar feedbacks recebidos.[1]

## Estrutura de diretórios

```text
.
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── service/
│   │   └── utils/
│   ├── package.json
│   └── vite.config.js
├── backend/
│   ├── src/main/java/com/example/peralta/
│   │   ├── DTO/
│   │   ├── entities/
│   │   ├── repositories/
│   │   ├── restcontrollers/
│   │   ├── security/
│   │   └── services/
│   ├── src/main/resources/
│   └── pom.xml
├── peraltadb.sql
└── LICENSE
```

A organização mostra um projeto acadêmico e funcional com boa separação entre responsabilidades, componentes reutilizáveis no frontend e camadas típicas de uma API corporativa no backend.[1]

## Como executar

### Pré-requisitos

- Node.js e npm para o frontend.[1]
- Java e Maven para o backend.[1]
- Banco de dados configurado a partir do script `peraltadb.sql` e dos parâmetros definidos em `application.properties`.[1]

### Backend

```bash
cd backend
./mvnw spring-boot:run
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```

Os comandos acima seguem diretamente a presença de `mvnw` no backend e dos scripts `dev`, `build` e `preview` definidos no `package.json` do frontend.[1]

## Perfis de acesso

O enunciado define dois perfis principais de uso: **cidadão** e **administrador**.[1] O cidadão pode se cadastrar na própria aplicação e utilizar o módulo de denúncias, enquanto o administrador possui acesso ao gerenciamento de órgãos, tipos, denúncias e feedbacks.[1]

## Diferenciais do projeto

- Separação clara entre frontend e backend.[1]
- Componentização no frontend com formulários, modais, tabelas e cards reutilizáveis.[1]
- Estrutura backend alinhada a boas práticas com camadas de controller, service, repository e security.[1]
- Controle de autenticação com JWT e diferenciação de permissões.[1]
- Aplicação de utilidade pública com foco em problemas reais do cotidiano urbano.[1]

## Melhorias futuras

- Adicionar documentação de endpoints com Swagger/OpenAPI.
- Implementar testes automatizados além do teste base do Spring Boot.
- Melhorar o tratamento de upload e armazenamento de imagens.
- Incluir status detalhado para o ciclo de vida da denúncia.
- Adicionar dashboard com indicadores administrativos.
- Publicar instruções completas de deploy para produção.

## Licença

Este projeto possui um arquivo `LICENSE` na raiz do repositório, indicando que há uma licença definida para distribuição e uso do código.[1]
