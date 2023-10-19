*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${locator_txt_first_name}   //input[@data-test = 'firstName']
${locator_txt_last_name}    //input[@data-test = 'lastName']
${locator_txt_zip_code}     //input[@data-test = 'postalCode']
${locator_btn_continue}     //input[@data-test = 'continue']
${locator_btn_cancel}       //button[@data-test = 'cancel']


*** Keywords ***
Checkout: Enter First Name
    [Arguments]  ${text}
    Wait Until Element Is Visible   ${locator_txt_first_name}
    Input Text    ${locator_txt_first_name}    ${text}

Checkout: Enter Last Name
    [Arguments]  ${text}
    Wait Until Element Is Visible   ${locator_txt_last_name}
    Input Text    ${locator_txt_last_name}    ${text}

Checkout: Enter Zip Code
    [Arguments]  ${text}
    Wait Until Element Is Visible   ${locator_txt_zip_code}
    Input Text    ${locator_txt_zip_code}    ${text}

Checkout: Click Continue
    Wait Until Element Is Visible   ${locator_btn_continue}
    Click Element    ${locator_btn_continue}

Checkout: Click Cancel
    Wait Until Element Is Visible   ${locator_btn_cancel}
    Click Element    ${locator_btn_cancel}