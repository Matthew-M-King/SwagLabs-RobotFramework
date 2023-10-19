*** Settings ***
Documentation     Checkout
...              
...               Tests related to user checkout
Resource          ../Resources/Setup.robot
Suite Setup       Setup Suite
Suite Teardown    Teardown Suite
Test Setup        Start At ProductInventory Page
Test Teardown     Teardown Test
Test Tags         checkout


*** Test Cases ***
Scenario: User is unable to checkout without products in the basket
    Given there are no products in the basket
     When I view the basket contents
     Then checkout should not be possible

Scenario: User retains basket content after cancelling checkout
    Given there are some products in the basket
      And the basket contents are displayed
      And the checkout process has begun
     When I cancel checkout
     Then basket should indicate correct product count

Scenario: During checkout user can see an overview of product listing
    Given there are some products in the basket
      And the basket contents are displayed
      And the checkout process has begun
     When I confirm user details
     Then the "CheckoutOverview" page should be displayed
      And all the selected products should be listed
      And the product details should be correct

Scenario: During checkout, user can see shipping and card details
    Given there are minimum products in the basket
      And the basket contents are displayed
     When I move to the "CheckoutOverview" page
     Then shipping and card details should be correct

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
     When I move to the "CheckoutOverview" page
     Then the ${value_to_check} of products should be correct
