*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Dialogs
Variables   ../Fixtures/CheckoutInfo.yml


*** Variables ***
${locator_summary_info}       //div[@class="summary_info_label"][contains(text(), "{0}")]
${locator_summary_value}      //div[@class="summary_value_label"][contains(text(), "{0}")]
${locator_subtotal_label}     //div[@class="summary_subtotal_label"]
${locator_summary_tax_label}  //div[@class="summary_tax_label"]
${locator_gtotal_label}       //div[contains(@class, "summary_total_label")]
${locator_finish_btn}         //button[@data-test="finish"]


*** Keywords ***
CheckoutOverview: Click Finish
    Click Element    ${locator_finish_btn}

CheckoutOverview: Get Price Total
    ${total_price}  Set Variable  ${0.00}
    FOR  ${product}  IN    @{current_product_tracker}
        ${price}  Set Variable  ${product}[Price]
        ${float_price}  Convert To Number   ${price[1:]}
        ${total_price}  Evaluate   ${total_price}+${float_price}
    END
    Return From Keyword   ${total_price}

CheckoutOverview: Calculate Tax Amount
    [Arguments]  ${subtotal}
    ${decimal_tax_rate}  Evaluate  ${tax_rate} / 100.0
    ${tax_amount}  Evaluate  ${subtotal} * ${decimal_tax_rate}
    ${formatted_tax_amount}  Evaluate  "%.2f" % ${tax_amount}
    Return From Keyword   ${formatted_tax_amount}

CheckoutOverview: Assert Shipping Provider Title
    ${locator}   Format String   ${locator_summary_info}   ${CheckoutInfo}[Shipping][title]
    Element Should Be Visible    ${locator}

CheckoutOverview: Assert Payment Title
    ${locator}   Format String   ${locator_summary_info}   ${CheckoutInfo}[Payment][title]
    Element Should Be Visible    ${locator}

CheckoutOverview: Assert Price Total Title
    ${locator}   Format String   ${locator_summary_info}   ${CheckoutInfo}[Total][title]
    Element Should Be Visible    ${locator}

CheckoutOverview: Assert Shipping Provider
    ${locator}   Format String   ${locator_summary_value}   ${CheckoutInfo}[Shipping][provider]
    Element Should Be Visible    ${locator}

CheckoutOverview: Assert Payment Card
    ${locator}   Format String   ${locator_summary_value}   ${CheckoutInfo}[Payment][card]
    Element Should Be Visible    ${locator}

CheckoutOverview: Assert Price Total
    ${sub_total_price}   CheckoutOverview: Get Price Total
    ${price_text}  Format String   ${CheckoutInfo}[Total][price]  ${sub_total_price}
    ${actual_sub_total}   Get Text   ${locator_subtotal_label}
    Should Be Equal As Strings    ${actual_sub_total}    ${price_text}

CheckoutOverview: Assert Applied Tax
    ${sub_total_price}   CheckoutOverview: Get Price Total
    ${tax}  CheckoutOverview: Calculate Tax Amount  ${sub_total_price}
    ${actual_tax}   Get Text   ${locator_summary_tax_label}
    Should Be Equal As Strings    ${actual_tax}    Tax: $${tax}

CheckoutOverview: Assert Grand Total
    ${sub_total_price}   CheckoutOverview: Get Price Total
    ${tax}  CheckoutOverview: Calculate Tax Amount  ${sub_total_price}
    ${grand_total}  Evaluate   ${sub_total_price}+${tax}
    ${actual_total}   Get Text   ${locator_gtotal_label}
    Should Be Equal As Strings    ${actual_total}    Total: $${grand_total}
