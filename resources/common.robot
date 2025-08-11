*** Settings ***
Library    SeleniumLibrary
Resource    amazon_page.robot
Library    BuiltIn
Library    OperatingSystem

*** Variables ***
${ENVIRONMENT}    dev
${BROWSER}    chrome
${TIMEOUT}    10s

*** Keywords ***
Abrir o navegador
    [Documentation]    Abre o navegador Chrome e maximiza a janela, passando argumentos do Chrome se existirem
    [Arguments]    ${url}
   ${CHROME ARGS STRING}=    Evaluate    os.getenv("SELENIUM_CHROME_ARGS", "")    modules=os
    Run Keyword If    '${chrome_args_string}' == ''    Open Browser    ${url}    chrome
    ...    ELSE
    ...    ${args_list}=    Split String    ${chrome_args_string}    separator=space
    ...    Open Browser    ${url}    chrome    options=${args_list}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}

Fechar o navegador
    [Documentation]    Fecha o navegador atual
    Close Browser

Clicar no elemento com retry
    [Documentation]    Clica em um elemento com tratamento de erro
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Click Element    ${locator}

Verificar se elemento está visível
    [Documentation]    Verifica se um elemento está visível na página
    [Arguments]    ${locator}    ${timeout}=${TIMEOUT}
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}

Tirar screenshot em caso de erro
    [Documentation]    Tira screenshot quando um teste falha
    Capture Page Screenshot    filename=erro_{index}.png
