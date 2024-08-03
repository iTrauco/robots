*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/common.robot

*** Variables ***
${OUTPUT_DIR}    ./output

*** Test Cases ***
Open Chrome and Wait for Manual Start
    [Setup]    Open Browser and Wait for Manual Start
    Perform Test Steps
    [Teardown]    Close Browser
