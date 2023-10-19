*** Settings ***
Library  SeleniumLibrary



*** Variables ***
${locator_back_to_products_btn}    //button[@data-test="back-to-products"]


*** Keywords ***
OrderComplete: Click Back To Home
    Wait Until Element Is Visible    ${locator_back_to_products_btn}
    Click Element   ${locator_back_to_products_btn}
