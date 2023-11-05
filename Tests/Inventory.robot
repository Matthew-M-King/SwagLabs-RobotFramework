*** Settings ***
Documentation     Inventory
...              
...               Tests related to the product inventory / product listings
Resource          ../Resources/Setup.robot
Suite Setup       Setup Suite
Suite Teardown    Teardown Suite
Test Setup        Start At ProductInventory Page
Test Teardown     Teardown Test
Test Tags         inventory  listings  products


*** Test Cases ***
Scenario: User can see correct product details in the product inventory
    When user views products
    Then the listed products should be correct

Scenario: User can view main product details
    Given products have been viewed
     When user looks at each product in detail
     Then each product details page should be correct

Scenario: User can sort products alphabetically A to Z by name
    Given there are no products in the basket
     When user sorts products by: Name (A to Z)
     Then the products should be sorted

Scenario: User can sort products alphabetically Z to A by name
    Given there are no products in the basket
     When user sorts products by: Name (Z to A)
     Then the products should be sorted

Scenario: User can sort products by price low to high
    Given there are no products in the basket
     When user sorts products by: Price (low to high)
     Then the products should be sorted

Scenario: User can sort products by price high to low
    Given there are no products in the basket
     When user sorts products by: Price (high to low)
     Then the products should be sorted

Scenario: Users on the product inventory page don't have accessability issues
    [Tags]  accessability
    Given there are no products in the basket
     When user checks for accessability problems
     Then the page should be accessible

Scenario: User views correct positioning of add to cart buttons within the product listings
    [Tags]  cosmetic  visual  layout
    Given there are no products in the basket
     When user views products
     Then details of products should be aligned correctly within their box

Scenario: User views correct positioning of key elements
    [Tags]  cosmetic  visual  layout
     When user checks the position of the shopping cart icon
      And checks the position of the menu icon
      And checks the position of the main title
     Then the position of each element should be correct
