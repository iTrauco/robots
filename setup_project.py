import os
import sys

def create_directory(path):
    if not os.path.exists(path):
        os.makedirs(path)

def create_file(path, content):
    with open(path, 'w') as file:
        file.write(content)

def main(project_name):
    # Define the directory structure
    directories = [
        project_name,
        os.path.join(project_name, 'output'),
        os.path.join(project_name, 'tasks'),
        os.path.join(project_name, 'resources'),
        os.path.join(project_name, 'keywords'),
        os.path.join(project_name, 'libraries'),
    ]

    # Create directories
    for directory in directories:
        create_directory(directory)
    
    # Create requirements.txt (for reference, not used with conda)
    requirements_content = """\
robotframework
robotframework-seleniumlibrary
selenium
"""
    create_file(os.path.join(project_name, 'requirements.txt'), requirements_content)

    # Create .gitignore
    gitignore_content = """\
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
env/
venv/
ENV/
env.bak/
venv.bak/
*.egg-info/
.dist/
.wheel/

# Environment variables
.env
.env.local
.pyenv
.python-version

# Robot Framework output files
output/
results/
log.html
output.xml
report.html
debug.log

# RPA framework specific
.robocorp/

# Editor directories and files
.idea/
.vscode/
*.swp
*.swo

# macOS
.DS_Store

# Windows
Thumbs.db
ehthumbs.db
Desktop.ini
$RECYCLE.BIN/

# Other
npm-debug.log*
yarn-debug.log*
yarn-error.log*
coverage/
.npm
*.log
"""
    create_file(os.path.join(project_name, '.gitignore'), gitignore_content)

    # Create task.robot
    task_robot_content = """\
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
"""
    create_file(os.path.join(project_name, 'tasks', 'task.robot'), task_robot_content)

    # Create common.robot
    common_robot_content = """\
*** Settings ***
Library    SeleniumLibrary
Resource   ../keywords/browser_keywords.robot
Resource   ../keywords/page_keywords.robot

*** Variables ***
${OUTPUT_DIR}    ./output

*** Keywords ***
Perform Test Steps
    # Placeholder for test steps
    Log    Test steps go here
"""
    create_file(os.path.join(project_name, 'resources', 'common.robot'), common_robot_content)

    # Create browser_keywords.robot
    browser_keywords_content = """\
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
"""
    create_file(os.path.join(project_name, 'keywords', 'browser_keywords.robot'), browser_keywords_content)

    # Create page_keywords.robot
    page_keywords_content = """\
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
"""
    create_file(os.path.join(project_name, 'keywords', 'page_keywords.robot'), page_keywords_content)

    # Create conda.yaml
    conda_yaml_content = """\
channels:
  - conda-forge
dependencies:
  - python=3.8
  - pip
  - pip:
      - robotframework
      - robotframework-seleniumlibrary
      - selenium
"""
    create_file(os.path.join(project_name, 'conda.yaml'), conda_yaml_content)

    # Create robot.yaml
    robot_yaml_content = """\
tasks:
  RunTasks:
    shell: python -m robot tasks/task.robot
artifacts:
  - output/*
"""
    create_file(os.path.join(project_name, 'robot.yaml'), robot_yaml_content)

    print(f'Project "{project_name}" has been created successfully.')

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python setup_project.py <project_name>')
    else:
        project_name = sys.argv[1]
        main(project_name)
