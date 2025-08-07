*** Settings ***
Documentation     Testes de automação do site Amazon.com.br
Resource          amazon_resources.robot
Test Setup        Abrir o navegador



*** Test Cases ***
Caso de teste 1: Acesso ao menu "Eletrônicos"
    [Documentation]  Teste de acesso ao menu "Eletrônicos"
    [Tags]           menus    categorias
    Acessar a home page do site Amazon.com.br
    Entrar no menu "Eletrônicos"
    Verificar se aparece a frase "Eletrônicos e Tecnologia"
    # Verificar se o título da página fica "Eletrônicos e Tecnologia |    Amazon.com.br"
    # Verificar se aparece a categoria "Computadores e Informática"

# Caso de teste 2: Pesquisa de um Produto
#     [Documentation]  Teste de pesquisa de um produto
#     [Tags]           Busca_produto    lista_busca
#     Acessar a home page do site Amazon.com.br 
#     Digitar o nome de produto "Xbox Series S" no campo de pesquisa
#     Clicar no botão de pesquisa 
#     Verificar se o resultado da pesquisa foi exibido
#     Verificar se o produto "Xbox Series S" aparece na lista de resultados
   
   









