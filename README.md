## Tech Playground – Pin People

### Tarefas Obrigatórias Implementadas
- Tarefa 1: Banco de Dados Básico
- Tarefa 3: Suíte de Testes
- Tarefa 9: API Simples

### Stack Tecnológico
- Ruby on Rails (API)
- PostgreSQL
- Docker / Docker Compose
- RSpec

### Configuração e Execução
```bash
docker compose up --build -d
docker compose exec api rails db:create db:migrate
docker compose exec api rails import:csv
```

### Endpoints da API

* `GET /api/v1/employees`
  - Retorna uma lista de colaboradores com seus departamentos.
  - Suporta filtragem por `department_id`.

* `GET /api/v1/metrics/enps`
  - Retorna a pontuação eNPS calculada com base nas respostas da pesquisa.
