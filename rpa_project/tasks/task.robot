*** Settings ***
Resource    ../resources/common.robot

*** Test Cases ***
Open Chrome And Wait For User
    Open Chrome Browser
    Wait For User Navigation
    [Teardown]    Close Browser
