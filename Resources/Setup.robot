*** Settings ***
Library         SeleniumLibrary
Resource        ../Resources/POM/_Main.robot
Resource        ../Resources/POM/LoginPage.robot
Resource        ../Resources/Variables/Urls.robot
Resource        ../Resources/Variables/Users.robot

Resource        ../Resources/StepDefinitions/_Main.robot
Resource        ../Resources/StepDefinitions/ProductListingSteps.robot
Resource        ../Resources/StepDefinitions/LoginSteps.robot
Resource        ../Resources/StepDefinitions/AddressFormSteps.robot
Resource        ../Resources/StepDefinitions/OverviewCommonSteps.robot
Resource        ../Resources/StepDefinitions/OverviewBasketSteps.robot
Resource        ../Resources/StepDefinitions/OverviewCheckoutSteps.robot


*** Variables ***
${current_handle_index}    0
${tax_rate}                ${8.00}
@{multi_failure_tracker}


*** Keywords ***
Setup Suite
    Open Browser    ${page_mapping}[Main]    browser=chrome
    Maximize Browser Window

Teardown Suite
    Close All Browsers

Teardown Test
    Delete All Cookies
    Execute JavaScript   localStorage.clear();
    Reload Page

Start At ${page} Page
    Login: Perform User Login    ${default_username}   ${default_password}
    Main: Go To Page    ${page}
