*** Settings ***
Library   SeleniumLibrary
Library   Collections
Library   String

Resource  ../Variables/SortOptions.robot


*** Variables ***
${locator_btn_details_add_cart}           //button[contains(@data-test, "add-to-cart")]
${locator_btn_details_rem_cart}           //button[contains(@data-test, "remove")]
${locator_inventory_details_item_name}    //div[contains(@class, "inventory_details_name")]
${locator_inventory_details_item_desc}    //div[contains(@class, "inventory_details_desc")]
${locator_inventory_details_item_price}   //div[contains(@class, "inventory_details_price")]
${locator_inventory_details_item_image}   //img[contains(@class, "inventory_details_img")]
${locator_back_to_products}               //button[@data-test="back-to-products"]
${locator_text}                           [contains(text(), "{0}")]


*** Keywords ***
ProductsDetails: Get Image Src
    Run Keyword And Return   Get Element Attribute    ${locator_inventory_details_item_image}    src

ProductsDetails: Get Name
    Run Keyword And Return   Get Text  ${locator_inventory_details_item_name}

ProductsDetails: Get Desc
    Run Keyword And Return   Get Text  ${locator_inventory_details_item_desc}

ProductsDetails: Get Price
    Run Keyword And Return   Get Text  ${locator_inventory_details_item_price}

ProductsDetails: Click Back To Products
    Wait Until Element Is Visible    ${locator_back_to_products}
    Click Element    ${locator_back_to_products}

ProductDetails: Remove Product From Basket
    Wait Until Element Is Visible    ${locator_btn_details_rem_cart}
    Click Element    ${locator_btn_details_rem_cart}

ProductDetails: Assert Name
    [Arguments]  ${expected_name}
    ${actual}   Get Text  ${locator_inventory_details_item_name}
    Element Text Should Be    ${locator_inventory_details_item_name}    ${expected_name}
    ...  message=The product name was incorrect\n'${expected_name}'\n'${actual}'

ProductDetails: Assert Price
    [Arguments]  ${product_name}  ${expected_price}
    ${actual}   Get Text  ${locator_inventory_details_item_price}
    Element Text Should Be    ${locator_inventory_details_item_price}    ${expected_price}
    ...   message=The '${product_name}' price was incorrect\n'${expected_price}'\n'${actual}'

ProductDetails: Assert Desc
    [Arguments]  ${product_name}  ${expected_desc}
    ${desc}  ProductsDetails: Get Desc
    Should Contain    ${desc}    ${expected_desc}
    ...   msg=The '${product_name}' description was incorrect\n'${expected_desc}'\n'${desc}'

ProductDetails: Assert Image
    [Arguments]  ${product_name}  ${expected_image}
    ${img}  ProductsDetails: Get Image Src
    Should Contain    ${img}   ${expected_image}
    ...  msg=The '${product_name}' image was incorrect\n'${expected_image}'\n'${img}'

ProductDetails: Add Product To Basket
    Click Element  ${locator_btn_details_add_cart}