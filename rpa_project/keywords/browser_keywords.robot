*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
Open Browser and Wait for Manual Start
    Open Browser    about:blank    browser=chrome
    Maximize Browser Window
    [Prompt User]    Navigate to the desired page and press Enter to start the automation
    [Input]    Press Enter to continue...

Close Browser
    Close Browser
