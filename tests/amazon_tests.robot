*** Settings ***
Documentation    Testes automatizados para Amazon.com.br
Library    SeleniumLibrary
Resource    ../resources/common.robot
Resource    ../resources/amazon_page.robot

*** Variables ***
${ENVIRONMENT}    dev

*** Test Cases ***
# ===== TESTES DE SMOKE =====
Teste de Navegação Básica Amazon
    [Documentation]    Testa a navegação básica para a seção de eletrônicos
    [Tags]    smoke    amazon    navegacao    prioridade_alta
    [Setup]    Abrir o navegador    ${URL}
    [Teardown]    Fechar o navegador
    
    Acessar a home page do site Amazon.com.br
    Navegar para eletronicos

Teste de Verificação de Título da Página
    [Documentation]    Verifica se o título da página está correto
    [Tags]    smoke    amazon    titulo    prioridade_media
    [Setup]    Abrir o navegador    ${URL}
    [Teardown]    Fechar o navegador
    
    Acessar a home page do site Amazon.com.br

# ===== TESTES DE REGRESSÃO =====
Teste Completo de Navegação Amazon
    [Documentation]    Teste completo de navegação e verificação de elementos
    [Tags]    regressao    amazon    navegacao_completa    prioridade_alta
    [Setup]    Abrir o navegador    ${URL}
    [Teardown]    Fechar o navegador
    
    Acessar a home page do site Amazon.com.br
    Entrar no menu "Eletrônicos"
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

Teste de Verificação de Elementos Críticos
    [Documentation]    Verifica se todos os elementos críticos estão presentes
    [Tags]    regressao    amazon    elementos_criticos    prioridade_alta
    [Setup]    Abrir o navegador    ${URL}
    [Teardown]    Fechar o navegador
    
    Acessar a home page do site Amazon.com.br
    Verificar se elemento está visível    ${MENU_ELETRONICOS_LOCATOR}

# ===== TESTES DE PERFORMANCE =====
Teste de Carregamento Rápido
    [Documentation]    Verifica se a página carrega rapidamente
    [Tags]    performance    amazon    carregamento    prioridade_media
    [Setup]    Abrir o navegador    ${URL}
    [Teardown]    Fechar o navegador
    
    Acessar a home page do site Amazon.com.br 