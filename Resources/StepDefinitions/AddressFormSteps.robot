*** Settings ***
Resource   ../POM/AddressFormPage.robot
Variables  ../Fixtures/Users.yml


*** Keywords ***
### WHEN ###
${r:(user )?}confirms their details
    Checkout: Enter First Name   ${Users}[${default_username}][firstname]
    Checkout: Enter Last Name    ${Users}[${default_username}][lastname]
    Checkout: Enter Zip Code     ${Users}[${default_username}][zip]
    Checkout: Click Continue

${r:(user )?}cancels checkout
    Checkout: Click Cancel