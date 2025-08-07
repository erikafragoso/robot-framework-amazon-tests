*** Settings ***
Library    SeleniumLibrary
Resource    config_${ENVIRONMENT}.robot

*** Variables ***
${ENVIRONMENT}    dev
${MENU_ELETRONICOS_LOCATOR}    //a[contains(text(),'Eletrônicos')]
${TEXTO_ELETRONICOS}    Eletrônicos e Tecnologia
${PAGE_TITLE_AMAZON}    Amazon.com.br | Tudo pra você, de A a Z.

*** Keywords ***
Acessar a home page do site Amazon.com.br
    [Documentation]    Navega para a página inicial da Amazon
    Go To    ${URL}
    Verificar se elemento está visível    ${MENU_ELETRONICOS_LOCATOR}
    Verificar titulo da pagina    ${PAGE_TITLE_AMAZON}

Entrar no menu "Eletrônicos"
    [Documentation]    Clica no menu Eletrônicos da Amazon
    Clicar no elemento com retry    ${MENU_ELETRONICOS_LOCATOR}

Verificar se aparece a frase "Eletrônicos e Tecnologia"
    [Documentation]    Verifica se o texto "Eletrônicos e Tecnologia" está presente na página
    Wait Until Page Contains    ${TEXTO_ELETRONICOS}

Verificar titulo da pagina
    [Documentation]    Verifica se o título da página corresponde ao esperado
    [Arguments]    ${titulo_esperado}
    Title Should Be    ${titulo_esperado}

Navegar para eletronicos
    [Documentation]    Navega para a seção de eletrônicos e verifica o conteúdo
    Entrar no menu "Eletrônicos"
    Verificar se aparece a frase "Eletrônicos e Tecnologia"



    