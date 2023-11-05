*** Settings ***
Documentation     Checkout
...              
...               Tests related to user checkout
Library           SeleniumLibrary
Resource          ../Resources/Setup.robot
Suite Setup       Setup Suite
Suite Teardown    Teardown Suite
Test Setup        Start At ProductInventory Page
Test Teardown     Teardown Test
Test Tags         checkout


*** Test Cases ***
Scenario: User is unable to checkout without products in the basket
    Given there are no products in the basket
     When user views the basket contents
     Then checkout should not be possible

Scenario: User retains basket content after cancelling checkout
    Given there are some products in the basket
      And the basket contents are displayed
      And the checkout process has begun
     When user cancels checkout
     Then basket should indicate correct product count

Scenario: During checkout user can see an overview of product listing
    Given there are some products in the basket
      And the basket contents are displayed
      And the checkout process has begun
     When user confirms their details
     Then the "CheckoutOverview" page should be displayed
      And all the selected products should be listed
      And the product details should be correct

Scenario: During checkout, user can see shipping and card details
    Given there are minimum products in the basket
      And the basket contents are displayed
     When user moves to the "CheckoutOverview" page
     Then shipping and card details should be correct

Scenario: User can see a final message when checkout is completed
    Given there are minimum products in the basket
      And the "CheckoutOverview" page is displayed
     When user finishes checkout
     Then Page Should Contain    Thank you for your order!
      And Page Should Contain    Your order has been dispatched, and will arrive just as fast as the pony can get there!

Scenario: User can move back to the home page after checkout
    Given there are minimum products in the basket
      And the "CheckoutOverview" page is displayed
      And checkout is finished
     When user moves back to the home page
     Then the "ProductInventory" page should be displayed
      And there isn't any products in the basket

Scenario: During checkout with one product, user can see a calculation of product sub total
    ...    minimum  subtotal
    [Template]    Scenario Outline: Check Calculated Value    

Scenario: During checkout with some products, user can see a calculation of product sub total
    ...    some  subtotal
    [Template]    Scenario Outline: Check Calculated Value 

Scenario: During checkout with all products, user can see a calculation of product sub total
    ...    maximum  subtotal
    [Template]    Scenario Outline: Check Calculated Value

Scenario: During checkout with one product, user can see a calculation tax
    ...    minimum  tax
    [Template]    Scenario Outline: Check Calculated Value    

Scenario: During checkout with some products, user can see a calculation tax
    ...    some  tax
    [Template]    Scenario Outline: Check Calculated Value 

Scenario: During checkout with all products, user can see a calculation tax
    ...    maximum  tax
    [Template]    Scenario Outline: Check Calculated Value

Scenario: During checkout with one product, user can see a calculation grand total
    ...    minimum  grandtotal
    [Template]    Scenario Outline: Check Calculated Value    

Scenario: During checkout with some products, user can see a calculation grand total
    ...    some  grandtotal
    [Template]    Scenario Outline: Check Calculated Value 

Scenario: During checkout with all products, user can see a calculation grand total
    ...    maximum  grandtotal
    [Template]    Scenario Outline: Check Calculated Value 


*** Keywords ***
Scenario Outline: Check Calculated Value
    [Arguments]  ${amount}  ${value_to_check}
    Given there are ${amount} products in the basket
      And the basket contents are displayed
     When user moves to the "CheckoutOverview" page
     Then the ${value_to_check} of products should be correct
