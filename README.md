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
└── libraries/          # Bibliotecas customizadas
```

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