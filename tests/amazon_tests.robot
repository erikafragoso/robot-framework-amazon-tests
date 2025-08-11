*** Settings ***
Documentation    Testes automatizados para Amazon.com.br
Library    SeleniumLibrary
Library    BuiltIn
Resource    ../resources/common.robot
Resource    ../resources/amazon_page.robot

*** Variables ***
${ENVIRONMENT}    dev
${URL}    https://www.amazon.com.br

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
