*** Settings ***
Documentation     Basket
...     
...               Tests related to basket (cart) of selected products
Resource          ../Resources/Setup.robot
Suite Setup       Setup Suite
Suite Teardown    Teardown Suite
Test Setup        Start At ProductInventory Page
Test Teardown     Teardown Test
Test Tags         basket


*** Test Cases ***
Scenario: User is able to see a count of products currently in the basket
   Given there are some products in the basket
    When I remove some products from the basket
    Then basket should indicate correct product count

Scenario: User doesn't see a count of products in the basket when basket is empty
    Given there are some products in the basket
     When I remove all products from the basket
     Then basket shouldn't indicate a product count

Scenario: User can view a summary with a single product in the basket
    Given there are minimum products in the basket
     When I view the basket contents
     Then all the selected products should be listed
      And the product details should be correct

Scenario: User can view a summary with multiple products in the basket
    Given there are some products in the basket
     When I view the basket contents
     Then all the selected products should be listed
      And the product details should be correct

Scenario: User can view a summary with all products in the basket
    Given there are maximum products in the basket
     When I view the basket contents
     Then all the selected products should be listed
      And the product details should be correct

Scenario: User can add products to basket from product details
    Given there are some products in the basket added from product details
     When I view the basket contents
     Then all the selected products should be listed

Scenario: User can remove products from basket from product details
    Given there are some products in the basket
     When I remove some products from the basket in details view
      And I view the basket contents
     Then all the selected products should be listed

Scenario: User can view accurate summary of products in the basket after some were removed
    Given there are some products in the basket
      And some products have been removed from the basket
     When I view the basket contents
     Then all the selected products should be listed
      And the product details should be correct

Scenario: User retains Products in the basket after a session timeout
    Given there are some products in the basket
      And the session has timed out
     When I log back in
     Then basket should indicate correct product count

Scenario: User updating basket on one browser tab is reflected on another tab
    Given there are some products in the basket
      And the ProductInventory page is open on a new tab
      And some products have been removed from the basket
     When I switch to the previous tab
      And I view the basket contents
     Then all the selected products should be listed
      And the product details should be correct
