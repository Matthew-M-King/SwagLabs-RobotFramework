*** Settings ***
Resource   ../POM/OverviewCheckoutPage.robot


*** Keywords ***
### GIVEN ###
checkout is finished
    CheckoutOverview: Click Finish

### WHEN ###
${r:(user )?}finishes checkout
    CheckoutOverview: Click Finish


### THEN ###
shipping and card details should be correct
    CheckoutOverview: Assert Shipping Provider Title
    CheckoutOverview: Assert Payment Title
    CheckoutOverview: Assert Shipping Provider
    CheckoutOverview: Assert Payment Card

the ${type:(subtotal|grandtotal|tax)?} of products should be correct
    IF  "${type}"=="subtotal"
        CheckoutOverview: Assert Price Total
    ELSE IF   "${type}"=="grandtotal"
        CheckoutOverview: Assert Grand Total
    ELSE
        CheckoutOverview: Assert Applied Tax
    END
