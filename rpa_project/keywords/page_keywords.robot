*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Wait For Page To Load
    [Documentation]    Waits for a specific element to be visible, indicating that the page has loaded.
    [Arguments]    ${element_locator}
    Wait Until Element Is Visible    ${element_locator}    timeout=30s
