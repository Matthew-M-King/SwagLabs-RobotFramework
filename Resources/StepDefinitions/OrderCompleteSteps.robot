*** Settings ***
Resource   ../POM/OrderCompletePage.robot


*** Keywords ***
### WHEN ###
${r:(user )?}moves back to the home page
    OrderComplete: Click Back To Home
