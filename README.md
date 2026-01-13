# Tech Playground – Pin People

Solução robusta para processamento e análise de dados de feedback de colaboradores, utilizando Ruby on Rails 8 e PostgreSQL.

---

## 🛠️ Stack Tecnológica

| Camada | Tecnologia |
| :--- | :--- |
| **Backend** | Ruby on Rails 8.0 (API Mode) |
| **Banco** | PostgreSQL 15 |
| **Qualidade** | RuboCop, Brakeman |
| **Testes** | RSpec, FactoryBot |
| **DevOps** | Docker, Docker Compose |

---

## 🚀 Como Executar

### 1. Inicialização do Ambiente

```bash
# Subir containers e configurar banco
docker compose up --build -d
docker compose exec api rails db:setup

# Importar registros do CSV
docker compose exec api rails import:csv
```

### 2. Qualidade e Testes

```bash
docker compose exec api rspec
docker compose exec api bundle exec rubocop
docker compose exec api bundle exec brakeman
```

---

## 📡 API Endpoints

**Base URL:** `http://localhost:3000/api/v1`

| Método | Endpoint | Descrição |
| :--- | :--- | :--- |
| `GET` | `/employees` | Listagem de colaboradores (filtro: `?department_id=X`) |
| `GET` | `/metrics/enps` | Cálculo consolidado do eNPS da organização |

---

## 🏗️ Decisões Técnicas

*   **Integridade**: Constraints de banco (`NOT NULL`, `UNIQUE`) para garantir dados consistentes.
*   **Idempotência**: Importação CSV segura para re-execuções via `find_or_create_by!`.
*   **Contratos**: Uso de Serializers explícitos para definir a estrutura de resposta da API.
*   **Domínio**: Lógica de cálculo centralizada nos Models para melhor testabilidade.

---

## 📊 Estrutura de Dados

*   **`departments`**: Áreas da empresa.
*   **`employees`**: Dados cadastrais (Email único).
*   **`survey_responses`**: Respostas anônimas vinculadas a colaboradores (Unicidade por data/usuário).

---

## 👤 Autor

Projeto integrante do **Tech Playground Challenge - Pin People**.
