*** Settings ***
Resource   ../POM/AddressFormPage.robot
Resource   ../Variables/Users.robot


*** Keywords ***
### WHEN ###
I confirm user details
    ${user_map}  Evaluate   ${user_data_string}
    Checkout: Enter First Name   ${user_map}[${default_username}][firstname]
    Checkout: Enter Last Name    ${user_map}[${default_username}][lastname]
    Checkout: Enter Zip Code     ${user_map}[${default_username}][zip]
    Checkout: Click Continue

I cancel checkout
    Checkout: Click Cancel