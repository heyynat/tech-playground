# Tech Playground – Pin People

> Análise de dados de feedback de colaboradores com API RESTful, banco de dados otimizado e suite de testes completa.

---

## 📋 Sobre o Projeto

Este projeto implementa uma solução completa para análise de dados de pesquisa de clima organizacional, focando em três pilares fundamentais:

### ✅ Tarefas Implementadas

- **Tarefa 1**: Banco de Dados Básico
- **Tarefa 3**: Suíte de Testes Completa
- **Tarefa 9**: API REST

---

## 🛠️ Stack Tecnológica

- **Backend**: Ruby on Rails 8.0 (modo API)
- **Banco de Dados**: PostgreSQL 15
- **Testes**: RSpec com cobertura completa
- **Containerização**: Docker & Docker Compose

---

## 🚀 Configuração e Execução

### Pré-requisitos

- Docker
- Docker Compose

### Iniciar o Projeto

```bash
# 1. Subir os containers
docker compose up --build -d

# 2. Criar e configurar o banco de dados
docker compose exec api rails db:create db:migrate

# 3. Importar os dados do CSV
docker compose exec api rails import:csv
```

### Executar os Testes

```bash
# Executar toda a suíte de testes
docker compose exec api rspec

# Executar com formato detalhado
docker compose exec api rspec --format documentation
```

### Parar o Projeto

```bash
docker compose down
```

---

## 📡 Documentação da API

### Base URL
```
http://localhost:3000/api/v1
```

### Endpoints Disponíveis

#### 1. Listar Colaboradores

**Endpoint:** `GET /api/v1/employees`

**Descrição:** Retorna lista de colaboradores com informações de departamento.

**Parâmetros de Query:**
- `department_id` (opcional): Filtra colaboradores por departamento

**Exemplo de Requisição:**
```bash
curl http://localhost:3000/api/v1/employees
curl http://localhost:3000/api/v1/employees?department_id=1
```

**Exemplo de Resposta:**
```json
[
  {
    "id": 1,
    "name": "João Silva",
    "corporate_email": "joao@empresa.com",
    "position": "Desenvolvedor Sênior",
    "role": "Desenvolvimento",
    "location": "São Paulo",
    "gender": "Masculino",
    "generation": "Millennial",
    "company_tenure": "3 anos",
    "department": {
      "id": 1,
      "name": "Tecnologia"
    }
  }
]
```

---

#### 2. Calcular eNPS

**Endpoint:** `GET /api/v1/metrics/enps`

**Descrição:** Calcula e retorna a pontuação Employee Net Promoter Score (eNPS).

**Cálculo:** `eNPS = (% Promotores) - (% Detratores)`
- **Promotores**: respostas 9-10
- **Passivos**: respostas 7-8
- **Detratores**: respostas 0-6

**Exemplo de Requisição:**
```bash
curl http://localhost:3000/api/v1/metrics/enps
```

**Exemplo de Resposta:**
```json
{
  "enps": 45,
  "total_responses": 120
}
```

---

## 🏗️ Arquitetura e Decisões Técnicas

### 🔒 Integridade de Dados com Constraints de Banco

**Decisão:** Implementar constraints diretamente no PostgreSQL, além das validações Rails.

**Justificativa:**
- Protege a integridade dos dados mesmo em caso de imports diretos ou scripts externos
- Constraints `NOT NULL` em campos críticos (`employee_id`, `enps`)
- Índice único composto `(employee_id, responded_at)` garante unicidade

**Impacto:** Dados sempre consistentes, independente da origem.

---

### 🔄 Import Idempotente

**Decisão:** Utilizar `find_or_create_by!` ao invés de `create!` no import CSV.

**Justificativa:**
- Permite reprocessamento seguro dos dados
- Evita duplicação ao executar o import múltiplas vezes
- Produção-ready: facilita refresh de dados

**Implementação:**
```ruby
SurveyResponse.find_or_create_by!(
  employee: employee,
  responded_at: row["Data da Resposta"]
) do |response|
  # Define atributos apenas na criação
end
```

---

### 🎯 Serialização Explícita da API

**Decisão:** Criar serializers dedicados ao invés de usar `as_json` genérico.

**Justificativa:**
- Controle explícito do contrato da API
- Previne vazamento acidental de campos sensíveis
- Facilita versionamento e evolução da API
- Sem dependência de gems externas

**Implementação:**
```ruby
class EmployeeSerializer
  def as_json
    {
      id: @employee.id,
      name: @employee.name,
      # Campos específicos e controlados
    }
  end
end
```

---

### 📦 Separação de Responsabilidades

**Decisão:** Mover lógica de negócio dos controllers para os models.

**Justificativa:**
- Controllers focam apenas em orquestração HTTP
- Lógica de negócio centralizada e reutilizável
- Melhor testabilidade
- Facilita manutenção

**Exemplo:**
```ruby
# Model
class SurveyResponse
  def self.enps_score
    # Lógica de cálculo
  end
end

# Controller
def enps
  score = SurveyResponse.enps_score
  render json: { enps: score }
end
```

---

### ✅ Validações com Constantes Explícitas

**Decisão:** Definir `LIKERT_RANGE = (1..5).freeze` ao invés de valores hardcoded.

**Justificativa:**
- Autodocumentação do código
- Facilita manutenção e mudanças futuras
- Evita "magic numbers"
- Padrão consistente em todos os campos Likert

---

### 🧪 Testes Focados em Comportamento

**Decisão:** Escrever testes que validam comportamento, não implementação.

**Justificativa:**
- Testes mais resilientes a refactoring
- Validação de contratos de API
- Menor acoplamento com detalhes internos

**Exemplo:**
```ruby
# ✅ Testa comportamento
expect(body['enps']).to be_between(-100, 100)

# ❌ Testa implementação
expect(SurveyResponse).to receive(:where)
```

---

## 📊 Estrutura do Banco de Dados

### Tabelas Principais

#### `departments`
- `id`: Identificador único
- `name`: Nome do departamento

#### `employees`
- `id`: Identificador único
- `name`: Nome completo
- `corporate_email`: Email corporativo (único)
- `position`: Cargo
- `role`: Função
- `location`: Localidade
- `department_id`: Referência ao departamento
- Índices: `(department_id)`, `(corporate_email)`

#### `survey_responses`
- `id`: Identificador único
- `employee_id`: Referência ao colaborador (NOT NULL)
- `interest_in_role`: Interesse no cargo (1-5)
- `contribution`: Contribuição (1-5)
- `learning_and_development`: Aprendizado e desenvolvimento (1-5)
- `feedback`: Feedback (1-5)
- `manager_interaction`: Interação com gestor (1-5)
- `career_clarity`: Clareza sobre carreira (1-5)
- `permanence_expectation`: Expectativa de permanência (1-5)
- `enps`: Pontuação eNPS (0-10, NOT NULL)
- `responded_at`: Data da resposta
- Índices: `(employee_id, responded_at)` [UNIQUE], `(enps)`

---

## 🎯 Cobertura de Testes

```
25 exemplos, 0 falhas
```

### Categorias de Testes

- **Models**: Validações, associations, business logic
- **Requests**: Endpoints da API, contratos JSON
- **Integration**: Fluxos completos

---

## 📝 Notas de Desenvolvimento

### Convenções de Código
- Seguir padrões Rails
- Separation of concerns rigoroso
- Testes para toda lógica de negócio
- Documentação inline quando necessário

### Princípios Aplicados
- **DRY**: Don't Repeat Yourself
- **SOLID**: Especialmente Single Responsibility
- **Convention over Configuration**
- **Database-First Design**

---

## 👤 Autor

Desenvolvido como parte do **Tech Playground Challenge** da **Pin People**.

---

## 📄 Licença

Este projeto foi desenvolvido para fins de avaliação técnica.
