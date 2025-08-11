*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_OPTIONS}    --headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222

*** Keywords ***
Abrir o navegador para CI
    [Documentation]    Abre o navegador Chrome com configurações otimizadas para CI
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --remote-debugging-port=9222
    Open Browser    ${url}    chrome    options=${options}
    Maximize Browser Window
    Set Selenium Timeout    10s 