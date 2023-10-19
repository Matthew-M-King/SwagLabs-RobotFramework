*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${locator_div_cartlist}          //div[@class="cart_list"]
${locator_div_cartlist_item}     //div[@class="cart_item"]
${locator_item_name}             //div[@class="inventory_item_name"]
${locator_item_desc}             //div[@class="inventory_item_desc"]
${locator_item_price}            //div[@class="inventory_item_price"]


*** Keywords ***
Overview: Assert Product Count
    [Arguments]  ${amount}
    Page Should Contain Element    ${locator_div_cartlist_item}   limit=${${amount}}

Overview: Assert Product Name
    [Arguments]  ${expected_value}  ${index}
    Element Text Should Be    ${locator_div_cartlist_item}\[${index}]${locator_item_name}  ${expected_value}

Overview: Assert Product Desc
    [Arguments]  ${expected_value}  ${index}
    ${actual_text}  Get Text  ${locator_div_cartlist_item}\[${index}]${locator_item_desc}
    Should Contain    ${expected_value}    ${actual_text}

Overview: Assert Product Prices
    [Arguments]  ${expected_value}  ${index}
    Element Text Should Be    ${locator_div_cartlist_item}\[${index}]${locator_item_price}  ${expected_value}

Overview: Assert Products From Tracker
    FOR  ${index}  ${product}  IN ENUMERATE   @{current_product_tracker}
        ${index}  Evaluate  ${index}+1
        Overview: Assert Product Name    ${product}[Name]     ${index}
        Overview: Assert Product Desc    ${product}[Desc]     ${index}
        Overview: Assert Product Prices  ${product}[Price]    ${index}
    END
