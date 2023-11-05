*** Settings ***
Library    SeleniumLibrary
Variables   ../Fixtures/LoginErrors.yml


*** Variables ***
${locator_container_login}    //div[@id="login_button_container"]
${locator_input_username}     id:user-name
${locator_input_password}     id:password
${locator_btn_login}          id:login-button
${locator_error_msg}          //h3[@data-test="error"]


*** Keywords ***
Login: Input Username
    [Arguments]  ${text}
    Wait Until Element Is Visible    ${locator_input_username}
    Input Text    ${locator_input_username}    ${text}

Login: Input Password
    [Arguments]  ${text}
    Wait Until Element Is Visible    ${locator_input_password}
    Input Text    ${locator_input_password}    ${text}

Login: Click Login Button
    Wait Until Element Is Visible    ${locator_btn_login}
    Click Element    ${locator_btn_login}

Login: Perform User Login
    [Arguments]   ${username}   ${password}
    Login: Input Username  ${username}
    Login: Input Password  ${password}
    Login: Click Login Button

Login: Assert Error Message
    [Arguments]  ${msg_type}
    Wait Until Element Is Visible        ${locator_error_msg}
    ${expected_message}  Set Variable    ${LoginErrors}[${msg_type}]
    ${actual_message}    Get Text        ${locator_error_msg}
    Should Contain   ${actual_message}   ${expected_message}
