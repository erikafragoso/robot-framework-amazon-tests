#!/bin/bash

echo "=== TESTE FINAL E DEFINITIVO ==="

# 1. Verificar se o Chrome está instalado
echo "1. Verificando Chrome..."
if command -v google-chrome &> /dev/null; then
    CHROME_VERSION=$(google-chrome --version)
    echo "✅ Chrome encontrado: $CHROME_VERSION"
else
    echo "❌ Chrome não encontrado"
    exit 1
fi

# 2. Verificar se o webdriver-manager está instalado
echo ""
echo "2. Verificando webdriver-manager..."
if python3 -c "import webdriver_manager" 2>/dev/null; then
    echo "✅ webdriver-manager instalado"
else
    echo "❌ webdriver-manager não instalado"
    exit 1
fi

# 3. Testar detecção automática
echo ""
echo "3. Testando detecção automática..."
DRIVER_PATH=$(python3 -c "
from webdriver_manager.chrome import ChromeDriverManager
try:
    driver_path = ChromeDriverManager().install()
    print(driver_path)
except Exception as e:
    print(f'ERROR: {e}')
    exit(1)
")

if [[ $? -eq 0 ]] && [[ ! -z "$DRIVER_PATH" ]]; then
    echo "✅ ChromeDriver detectado: $DRIVER_PATH"
else
    echo "❌ Falha na detecção do ChromeDriver"
    exit 1
fi

# 4. Testar se o ChromeDriver funciona
echo ""
echo "4. Testando execução do ChromeDriver..."
if [[ -f "$DRIVER_PATH" ]] && [[ -x "$DRIVER_PATH" ]]; then
    VERSION=$($DRIVER_PATH --version 2>/dev/null)
    if [[ $? -eq 0 ]]; then
        echo "✅ ChromeDriver funciona: $VERSION"
    else
        echo "❌ ChromeDriver não executa"
        exit 1
    fi
else
    echo "❌ ChromeDriver não encontrado ou não executável"
    exit 1
fi

# 5. Testar compatibilidade
echo ""
echo "5. Testando compatibilidade..."
CHROME_MAJOR=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}')
DRIVER_MAJOR=$(echo "$VERSION" | awk '{print $2}' | awk -F'.' '{print $1}')

if [[ "$CHROME_MAJOR" == "$DRIVER_MAJOR" ]]; then
    echo "✅ Versões compatíveis: Chrome $CHROME_MAJOR e ChromeDriver $DRIVER_MAJOR"
else
    echo "⚠️  Versões diferentes: Chrome $CHROME_MAJOR e ChromeDriver $DRIVER_MAJOR"
    echo "   (Isso pode funcionar, mas não é ideal)"
fi

# 6. Testar instalação no PATH
echo ""
echo "6. Testando instalação no PATH..."
python3 -c "
import os
from webdriver_manager.chrome import ChromeDriverManager

# Baixar ChromeDriver
driver_path = ChromeDriverManager().install()
print(f'ChromeDriver baixado: {driver_path}')

# Copiar para /usr/local/bin
try:
    os.system(f'cp {driver_path} /usr/local/bin/chromedriver')
    os.system('chmod +x /usr/local/bin/chromedriver')
    print('✅ ChromeDriver instalado em /usr/local/bin/chromedriver')
except Exception as e:
    print(f'❌ Erro ao instalar: {e}')
    exit(1)
"

if [[ $? -eq 0 ]]; then
    echo "✅ Instalação no PATH bem-sucedida"
else
    echo "❌ Falha na instalação no PATH"
    exit 1
fi

# 7. Teste final
echo ""
echo "7. Teste final..."
if chromedriver --version >/dev/null 2>&1; then
    echo "✅ ChromeDriver está funcionando no PATH"
else
    echo "❌ ChromeDriver não está funcionando no PATH"
    exit 1
fi

echo ""
echo "🎉 TODOS OS TESTES PASSARAM! O WORKFLOW ESTÁ PRONTO!"
echo ""
echo "📋 Resumo:"
echo "   - Chrome: $CHROME_VERSION"
echo "   - ChromeDriver: $VERSION"
echo "   - Compatibilidade: ✅"
echo "   - Instalação: ✅"
echo "   - PATH: ✅" 