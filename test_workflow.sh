#!/bin/bash

echo "=== TESTE COMPLETO DO WORKFLOW ==="

# 1. Verificar se o Chrome está instalado
echo "1. Verificando Chrome..."
if command -v google-chrome &> /dev/null; then
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}')
    echo "✅ Chrome encontrado. Versão: $CHROME_VERSION"
else
    echo "❌ Chrome não encontrado"
    exit 1
fi

# 2. Testar detecção de versão do ChromeDriver
echo ""
echo "2. Testando detecção do ChromeDriver..."
CHROMEDRIVER_VERSION=""

# Método 1: Tentar versão específica
TEMP_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
if [[ ! "$TEMP_VERSION" == *"<?xml"* ]] && [[ ! -z "$TEMP_VERSION" ]]; then
    CHROMEDRIVER_VERSION=$TEMP_VERSION
    echo "✅ Found specific version: $CHROMEDRIVER_VERSION"
else
    echo "⚠️  Specific version not found, trying compatible versions..."
    
    # Método 2: Tentar versões próximas
    for i in {1..10}; do
        TRY_VERSION=$((CHROME_VERSION - i))
        TEMP_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$TRY_VERSION")
        if [[ ! "$TEMP_VERSION" == *"<?xml"* ]] && [[ ! -z "$TEMP_VERSION" ]]; then
            CHROMEDRIVER_VERSION=$TEMP_VERSION
            echo "✅ Found compatible version: $CHROMEDRIVER_VERSION (for Chrome $TRY_VERSION)"
            break
        fi
    done
    
    # Método 3: Usar versão mais recente
    if [[ -z "$CHROMEDRIVER_VERSION" ]]; then
        echo "⚠️  Compatible version not found, using latest..."
        CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE")
        echo "✅ Using latest version: $CHROMEDRIVER_VERSION"
    fi
fi

# 3. Testar download
echo ""
echo "3. Testando download do ChromeDriver..."
if [[ ! -z "$CHROMEDRIVER_VERSION" ]]; then
    wget -O /tmp/chromedriver_test.zip "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
    if [ $? -eq 0 ]; then
        echo "✅ Download successful"
        
        # Testar extração
        unzip -t /tmp/chromedriver_test.zip > /dev/null
        if [ $? -eq 0 ]; then
            echo "✅ ZIP file is valid"
            
            # Extrair e testar
            unzip -o /tmp/chromedriver_test.zip -d /tmp/ > /dev/null
            chmod +x /tmp/chromedriver
            /tmp/chromedriver --version
            if [ $? -eq 0 ]; then
                echo "✅ ChromeDriver works correctly"
            else
                echo "❌ ChromeDriver failed to run"
            fi
        else
            echo "❌ ZIP file is corrupted"
        fi
    else
        echo "❌ Download failed"
    fi
else
    echo "❌ No ChromeDriver version found"
fi

# 4. Limpar
rm -f /tmp/chromedriver_test.zip /tmp/chromedriver

echo ""
echo "=== TESTE CONCLUÍDO ===" 