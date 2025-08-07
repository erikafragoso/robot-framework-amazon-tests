# Projeto de Testes Automatizados - Amazon

Este projeto contém testes automatizados para o site Amazon.com.br usando Robot Framework.

## Estrutura do Projeto

```
Robotframework/
├── resources/           # Recursos e configurações
│   ├── common.robot    # Keywords comuns
│   ├── amazon_page.robot # Page Objects da Amazon
│   └── config_*.robot  # Configurações por ambiente
├── tests/              # Testes organizados por tags
│   └── amazon_tests.robot # Todos os testes em um arquivo
├── results/            # Resultados dos testes
│   ├── logs/
│   ├── reports/
│   └── screenshots/
├── .github/workflows/  # Pipelines CI/CD
│   ├── robot-tests.yml # Pipeline completa
│   ├── quick-tests.yml # Pipeline rápida
│   └── environment-tests.yml # Pipeline por ambiente
└── libraries/          # Bibliotecas customizadas
```

## CI/CD Pipelines

### 🚀 Pipelines Automáticas

O projeto possui 3 pipelines configuradas no GitHub Actions:

#### 1. **Pipeline Completa** (`robot-tests.yml`)
- **Trigger**: Push/Pull Request na main + Schedule diário (6h)
- **Jobs**:
  - Smoke Tests (testes básicos)
  - Regression Tests (testes completos)
  - Code Quality Check (Robocop)

#### 2. **Pipeline Rápida** (`quick-tests.yml`)
- **Trigger**: Push/Pull Request na main
- **Jobs**: Apenas testes de alta prioridade
- **Tempo**: ~2-3 minutos

#### 3. **Pipeline por Ambiente** (`environment-tests.yml`)
- **Trigger**: Manual (workflow_dispatch)
- **Jobs**: Testes específicos por ambiente (dev/hom/prod)

### 📊 Como Acessar os Resultados

1. **GitHub Actions**: Vá para a aba "Actions" no seu repositório
2. **Artifacts**: Baixe os relatórios HTML/XML após cada execução
3. **Logs**: Veja os logs detalhados de cada job

### 🔧 Como Executar Manualmente

1. Vá para **Actions** no GitHub
2. Clique em **Environment Tests**
3. Clique em **Run workflow**
4. Selecione o ambiente (dev/hom/prod)
5. Clique em **Run workflow**

## Como Executar

### Execução por Ambiente

```bash
# Desenvolvimento (apenas smoke tests)
./run_dev.sh

# Homologação (regressão completa)
./run_hom.sh

# Produção (todos os testes)
./run_prod.sh
```

### Execução por Tipo de Teste

```bash
# Apenas testes de smoke
./run_smoke.sh

# Apenas testes de regressão
./run_regression.sh

# Todos os testes
./run_all.sh
```

### Execução Manual

```bash
# Executar todos os testes
robot --outputdir results tests/amazon_tests.robot

# Executar apenas smoke tests
robot --include smoke tests/amazon_tests.robot

# Executar apenas regressão
robot --include regressao tests/amazon_tests.robot

# Executar com ambiente específico
robot -v ENVIRONMENT:prod tests/amazon_tests.robot

# Executar testes de alta prioridade
robot --include prioridade_alta tests/amazon_tests.robot

# Executar testes excluindo performance
robot --exclude performance tests/amazon_tests.robot
```

## Tags Disponíveis

### Por Tipo de Teste
- `smoke`: Testes básicos de funcionalidade
- `regressao`: Testes completos de regressão
- `performance`: Testes de performance

### Por Funcionalidade
- `amazon`: Testes específicos da Amazon
- `navegacao`: Testes de navegação
- `titulo`: Testes de verificação de título
- `navegacao_completa`: Testes completos de navegação
- `elementos_criticos`: Testes de elementos críticos
- `carregamento`: Testes de carregamento

### Por Prioridade
- `prioridade_alta`: Testes de alta prioridade
- `prioridade_media`: Testes de média prioridade

## Configuração de Ambientes

- `dev`: Ambiente de desenvolvimento
- `hom`: Ambiente de homologação
- `prod`: Ambiente de produção

## Vantagens da Estrutura com Tags

1. **Manutenção Simplificada**: Todos os testes em um arquivo
2. **Flexibilidade**: Fácil execução de subconjuntos específicos
3. **Organização**: Testes organizados por seções comentadas
4. **Escalabilidade**: Fácil adição de novos testes
5. **Reutilização**: Mesmos recursos para diferentes tipos de teste

## Relatórios

Após a execução, os relatórios estarão disponíveis em:
- `results/log.html`: Log detalhado
- `results/report.html`: Relatório de execução
- `results/output.xml`: Dados em XML

## Dependências

```bash
pip install -r requirements.txt
```

### Dependências Principais:
- `robotframework==6.1.1`
- `robotframework-seleniumlibrary==6.2.0`
- `robotframework-robocop==3.0.0`
- `selenium==4.15.2` 