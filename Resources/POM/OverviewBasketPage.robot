*** Settings ***
Resource  OverviewCommonPage.robot


*** Variables ***
${locator_btn_checkout}          //button[@data-test="checkout"]


*** Keywords ***
Basket: Click Checkout Button
    Wait Until Element Is Visible    ${locator_btn_checkout}
    Click Element    ${locator_btn_checkout}

Basket: Assert Checkout Button Disabled
    Element Should Be Disabled    ${locator_btn_checkout}
