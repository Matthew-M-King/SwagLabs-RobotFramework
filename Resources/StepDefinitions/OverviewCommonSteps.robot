*** Settings ***
Resource   ../POM/OverviewCommonPage.robot


*** Keywords ***
### THEN ###
all the selected products should be listed
    Overview: Assert Product Count  ${current_product_amount}

the product details should be correct
    Overview: Assert Products From Tracker
