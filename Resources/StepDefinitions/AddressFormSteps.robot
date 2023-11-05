*** Settings ***
Resource   ../POM/AddressFormPage.robot
Variables  ../Fixtures/Users.yml


*** Keywords ***
### WHEN ###
I confirm user details
    Checkout: Enter First Name   ${Users}[${default_username}][firstname]
    Checkout: Enter Last Name    ${Users}[${default_username}][lastname]
    Checkout: Enter Zip Code     ${Users}[${default_username}][zip]
    Checkout: Click Continue

I cancel checkout
    Checkout: Click Cancel