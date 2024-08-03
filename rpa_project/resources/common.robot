*** Settings ***
Library    SeleniumLibrary
Library    Dialogs

*** Variables ***
${CHROME_PATH}    /usr/bin/google-chrome  # Ensure this path is correct for your system

*** Keywords ***
Open Chrome Browser
    [Documentation]    Opens a blank Chrome browser.
    Open Browser    about:blank    browser=chrome
    Set Window Size    1920    1080
    Log    Opened Chrome browser

Wait For User Navigation
    [Documentation]    Waits for the user to navigate and press Enter.
    Log    Waiting for user to navigate and press Enter
    Execute Manual Step    Please navigate to the desired page and press OK when ready.
    Log    User has navigated
