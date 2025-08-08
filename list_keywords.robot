*** Settings ***
Library    BuiltIn

*** Test Cases ***
List BuiltIn Keywords
    ${keywords}=    Get Library Keywords    BuiltIn
    Log    ${keywords} 