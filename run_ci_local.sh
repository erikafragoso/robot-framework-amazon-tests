#!/bin/bash
set -e

# 1. Instalar dependências do sistema (apenas para Ubuntu/Debian)
echo "Instalando Google Chrome..."
sudo apt-get update
sudo apt-get install -y wget gnupg2
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# 2. Instalar ChromeDriver
echo "Instalando ChromeDriver..."
pip install --user webdriver-manager
python3 -c "import os; from webdriver_manager.chrome import ChromeDriverManager; path = ChromeDriverManager().install(); os.system(f'cp {path} /usr/local/bin/chromedriver'); os.system('chmod +x /usr/local/bin/chromedriver')"
chromedriver --version

# 3. Instalar dependências Python
echo "Instalando dependências Python..."
pip install --user robotframework robotframework-seleniumlibrary robotframework-robocop

# 4. Configurar opções do Chrome
echo "Configurando opções do Chrome..."
mkdir -p /tmp/chrome-profile
export SELENIUM_CHROME_ARGS="--headless=new --no-sandbox --disable-dev-shm-usage --user-data-dir=/tmp/chrome-profile"

# 5. Executar os testes (smoke e regressão)
echo "Executando testes SMOKE..."
robot --outputdir results --timestampoutputs --include smoke tests/amazon_tests.robot

echo "Executando testes REGRESSÃO..."
robot --outputdir results --timestampoutputs --include regressao tests/amazon_tests.robot

echo "Testes finalizados. Resultados em ./results/" 