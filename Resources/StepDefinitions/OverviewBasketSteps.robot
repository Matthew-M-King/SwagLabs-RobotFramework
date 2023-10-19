*** Settings ***
Resource   ../POM/OverviewBasketPage.robot


*** Keywords ***
### GIVEN ###
the checkout process has begun
    Basket: Click Checkout Button

### WHEN ###
I begin the checkout process
    Basket: Click Checkout Button

### THEN ###
checkout should not be possible
    Basket: Assert Checkout Button Disabled

