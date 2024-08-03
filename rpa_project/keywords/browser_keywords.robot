*** Settings ***
Library    Browser

*** Keywords ***
Open Chrome Browser
    [Documentation]    Opens a blank Chrome browser.
    Open Browser    about:blank    browser=chromium

Wait For User Navigation
    [Documentation]    Waits for the user to navigate and press Enter.
    Press Keys    locator=css:body    \n
