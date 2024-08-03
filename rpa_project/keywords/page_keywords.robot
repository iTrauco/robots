*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Select First Dropdown Item
    Select From List By Index    xpath=//select[@id='your-dropdown-id']    0
    Click Button    xpath=//button[@id='submit-button-id']

Process Pages For Option
    [Arguments]    ${option}
    Create Directory For Option    ${option}
    ${page_count}=    Get Page Count
    :FOR    ${i}    IN RANGE    1    ${page_count}+1
    \    Capture And Save Page Screenshot    ${option}    ${i}
    \    Save Page Source    ${option}    ${i}
    \    Go To Next Page

Get Page Count
    ${page_count}=    Get Element Count    xpath=//div[@class='pagination']/a
    [Return]    ${page_count}

Capture And Save Page Screenshot
    [Arguments]    ${option}    ${page_number}
    Capture Page Screenshot    ${OUTPUT_DIR}/${option}/screenshot_${page_number}.png

Save Page Source
    [Arguments]    ${option}    ${page_number}
    ${source}=    Get Page Source
    Create File    ${OUTPUT_DIR}/${option}/page_${page_number}.html    ${source}

Go To Next Page
    Click Element    xpath=//a[@class='next-page-link']

Create Directory For Option
    [Arguments]    ${option}
    Create Directory    ${OUTPUT_DIR}/${option}
