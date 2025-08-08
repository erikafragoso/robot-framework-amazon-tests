*** Settings ***
Library    SeleniumLibrary
Resource    amazon_page.robot
Library    BuiltIn

*** Variables ***
${ENVIRONMENT}    dev
${BROWSER}    chrome
${TIMEOUT}    10s
${CHROME ARGS STRING}    Get Environment Variable    SELENIUM_CHROME_ARGS    ''
*** Keywords ***
Abrir o navegador
    [Documentation]    Abre o navegador Chrome e maximiza a janela
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${args}=    Create List
    FOR    ${arg}    IN    @{args}
        Run Keyword If    '${arg}' != ''    Call Method    ${options}    add_argument    ${arg}
    END
    Open Browser    ${url}    chrome    options=${options}
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