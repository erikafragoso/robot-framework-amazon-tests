#!/bin/bash

echo "=== Testando instalação do ChromeDriver ==="

# Verificar se o Chrome está instalado
echo "1. Verificando se o Chrome está instalado..."
if command -v google-chrome &> /dev/null; then
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}')
    echo "✅ Chrome encontrado. Versão: $CHROME_VERSION"
else
    echo "❌ Chrome não encontrado. Instalando..."
    sudo apt-get update
    sudo apt-get install -y wget gnupg2
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
    sudo apt-get update
    sudo apt-get install -y google-chrome-stable
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}')
    echo "✅ Chrome instalado. Versão: $CHROME_VERSION"
fi

# Testar o método de download do ChromeDriver
echo ""
echo "2. Testando download do ChromeDriver..."
echo "Chrome version: $CHROME_VERSION"

# Download ChromeDriver usando o método mais robusto
CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
if [ -z "$CHROMEDRIVER_VERSION" ]; then
    echo "⚠️  Versão específica não encontrada, usando versão mais recente..."
    CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE")
fi

echo "ChromeDriver version: $CHROMEDRIVER_VERSION"

# Testar se a URL do ChromeDriver existe
echo ""
echo "3. Testando se a URL do ChromeDriver existe..."
CHROMEDRIVER_URL="https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
echo "URL: $CHROMEDRIVER_URL"

if curl --output /dev/null --silent --head --fail "$CHROMEDRIVER_URL"; then
    echo "✅ URL do ChromeDriver é válida"
else
    echo "❌ URL do ChromeDriver não é válida"
    exit 1
fi

# Fazer download de teste
echo ""
echo "4. Fazendo download de teste..."
wget -O /tmp/chromedriver_test.zip "$CHROMEDRIVER_URL"
if [ $? -eq 0 ]; then
    echo "✅ Download realizado com sucesso"
    ls -la /tmp/chromedriver_test.zip
else
    echo "❌ Falha no download"
    exit 1
fi

# Testar extração
echo ""
echo "5. Testando extração..."
unzip -t /tmp/chromedriver_test.zip > /dev/null
if [ $? -eq 0 ]; then
    echo "✅ Arquivo ZIP é válido"
else
    echo "❌ Arquivo ZIP corrompido"
    exit 1
fi

# Limpar arquivo de teste
rm -f /tmp/chromedriver_test.zip

echo ""
echo "🎉 Todos os testes passaram! A correção está funcionando." 