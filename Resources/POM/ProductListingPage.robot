*** Settings ***
Library   SeleniumLibrary
Library   Collections
Library   String

Variables    ../Fixtures/SortOptions.yml
Resource    ProductDetailsPage.robot


*** Variables ***
${locator_products}                  //div[@class="inventory_item"]
${locator_btn_add_cart}              //button[contains(@data-test, "add-to-cart")]
${locator_btn_rem_cart}              //button[contains(@data-test, "remove")]
${locator_inventory_item_name}       //div[contains(@class, "inventory_item_name")]
${locator_inventory_item_desc}       //div[contains(@class, "inventory_item_desc")]
${locator_inventory_item_price}      //div[contains(@class, "inventory_item_price")]
${locator_inventory_item_image}      //div[contains(@class, "inventory_item_img")]//img
${locator_back_to_products}          //button[@data-test="back-to-products"]
${locator_sort_container}            //select[contains(@class, "product_sort_container")]
${locator_text}                      [contains(text(), "{0}")]


*** Keywords ***
Products: Sort
    [Arguments]  ${option}
    Select From List By Value   ${locator_sort_container}   ${SortOptions}[${option}]

Products: Get Image Src
    [Arguments]  ${index}
    Run Keyword And Return   Get Element Attribute    ${locator_products}\[${index}]${locator_inventory_item_image}    src

Products: Get Name
    [Arguments]  ${index}
    Run Keyword And Return   Get Text  ${locator_products}\[${index}]${locator_inventory_item_name}

Products: Get Desc
    [Arguments]  ${index}
    Run Keyword And Return   Get Text  ${locator_products}\[${index}]${locator_inventory_item_desc}

Products: Get Price
    [Arguments]  ${index}
    Run Keyword And Return   Get Text  ${locator_products}\[${index}]${locator_inventory_item_price}

Products: Click Product Name Link
    [Arguments]  ${text}
    ${locator}  Format String   ${locator_inventory_item_name}${locator_text}   ${text}
    Click Element  ${locator}

Products: Click Product Name By Index
    [Arguments]  ${index}
    Click Element  ${locator_products}\[${index}]${locator_inventory_item_name}

Products: Click Back To Products
    Wait Until Element Is Visible    ${locator_back_to_products}
    Click Element    ${locator_back_to_products}

Products: Work Out Amount
    [Arguments]   ${type}
    ${amount}  Set Variable   ${NONE}
    IF  "${type}"=="minimum"
        Return From Keyword    1
    ELSE IF  "${type}"=="maximum"
        Run Keyword And Return   Products: Count
    ELSE IF  "${type}"=="no"
        Return From Keyword  0
    ELSE
        ${count}   Products: Count
        Run Keyword And Return    Evaluate    -(-${count}//2)
    END

Products: Add Number Of Products To Basket
    [Arguments]  ${amount}   ${from_details_page}=${FALSE}
    ${products}  Products: Get
    ${sliced_products}   Get Slice From List  ${products}  0  ${amount}
    @{product_tracker}  Create List

    FOR  ${index}  ${product}  IN ENUMERATE  @{sliced_products}
        ${index}  Evaluate  ${index}+1
        IF  ${from_details_page}
            Products: Click Product Name By Index  ${index}
            ProductDetails: Add Product To Basket
            ProductsDetails: Click Back To Products
        ELSE
            Products: Add To Cart By Index  ${index}
        END
        ${product_tracker}  Products: Update Tracker  ${product_tracker}  ${index}
    END
    Set Test Variable    ${current_product_tracker}  ${product_tracker}

Products: Remove Subset
    [Arguments]  ${from_details_view}=${FALSE}
    ${amount}    Evaluate    -(-${current_product_amount}//2)
    ${amount}    Set Variable If    ${amount} > ${current_product_amount}    ${current_product_amount}    ${amount}
    Products: Remove Number Of Products From Basket    ${amount}  ${from_details_view}
    ${new_amount}    Evaluate    ${current_product_amount} - ${amount}
    Set Test Variable    ${current_product_amount}    ${new_amount}

Products: Remove Number Of Products From Basket
    [Arguments]  ${amount}  ${from_details_page}=${FALSE}
    ${removed_count}=  Set Variable  0
    @{products_to_keep}=  Create List
    FOR  ${index}  ${product}  IN ENUMERATE  @{current_product_tracker}
        ${product_index_ui}=  Set Variable   ${product}[Index]
        Run Keyword If  ${removed_count} == ${amount}  Exit For Loop
        
        IF  ${from_details_page}
            Products: Click Product Name By Index  ${product_index_ui}
            ProductDetails: Remove Product From Basket
            ProductsDetails: Click Back To Products
        ELSE
            Products: Remove From Cart By Index  ${product_index_ui}
        END
        ${removed_count}=  Evaluate  ${removed_count} + 1
    END
    @{products_to_keep}=  Get Slice From List  ${current_product_tracker}  ${amount}
    Set Test Variable  ${current_product_tracker}  ${products_to_keep}

Products: Get
    Run Keyword And Return    Get Web Elements    ${locator_products}

Products: Get Product Details
    ${product_len}  Products: Count
    &{products}  Create Dictionary
    FOR   ${index}  IN RANGE  1  ${product_len}+1
        ${name}   Products: Get Name       ${index}
        ${desc}   Products: Get Desc       ${index}
        ${price}  Products: Get Price      ${index}
        ${image}  Products: Get Image Src  ${index}
        &{details}  Create Dictionary
        ...    desc=${desc}
        ...    price=${price}
        ...    image=${image}
        &{main}     Create Dictionary   ${name}=${details}
        Set To Dictionary  ${products}  ${name}  ${details}
    END
    Return From Keyword  ${products}

Products: Get Product Names
    ${actual_product_list}  Create List
    ${product_names}  Get WebElements    ${locator_inventory_item_name}
    FOR  ${name}  IN   @{product_names}
        ${text}   Get Text    ${name}
        Append To List   ${actual_product_list}   ${text}
    END
    Return From Keyword   ${actual_product_list}

Products: Get Product Prices
    ${actual_product_list}  Create List
    ${product_prices}  Get WebElements    ${locator_inventory_item_price}
    FOR  ${price}  IN   @{product_prices}
        ${text}   Get Text    ${price}
        ${float_price}  Convert To Number   ${text[1:]}
        Append To List   ${actual_product_list}   ${float_price}
    END
    Return From Keyword   ${actual_product_list}

Products: Count
    ${products}  Products: Get
    Run Keyword And Return    Get Length    ${products}

Products: Add To Cart By Index
    [Arguments]  ${index}
    ${locator}  Catenate  ${locator_products}\[${index}]${locator_btn_add_cart}
    ${add_to_cart}   Get WebElement   ${locator}
    Click Element    ${add_to_cart}

Products: Remove From Cart By Index
    [Arguments]  ${index}
    ${locator}  Catenate  ${locator_products}\[${index}]${locator_btn_rem_cart}
    ${add_to_cart}   Get WebElement   ${locator}
    Click Element    ${add_to_cart}

Products: Update Tracker
    [Arguments]  ${tracker}  ${index}
    ${name}   Products: Get Name   ${index}
    ${desc}   Products: Get Desc   ${index}
    ${price}  Products: Get Price  ${index}
    &{item}   Create Dictionary
    ...    Name=${name}
    ...    Desc=${desc}
    ...    Price=${price}
    ...    Index=${index}
    Append To List  ${tracker}  ${item}
    Return From Keyword  ${tracker}

Products: Assert Sorted: Name (A to Z)
    ${actual_product_list}   Products: Get Product Names
    ${sorted_list}  Evaluate  sorted(${actual_product_list})
    Lists Should Be Equal  ${actual_product_list}  ${sorted_list}

Products: Assert Sorted: Name (Z to A)
    ${actual_product_list}   Products: Get Product Names
    ${sorted_list}  Evaluate  sorted(${actual_product_list}, reverse=True)
    Lists Should Be Equal  ${actual_product_list}  ${sorted_list}

Products: Assert Sorted: Price (low to high)
    ${actual_product_list}   Products: Get Product Prices
    ${sorted_list}  Evaluate  sorted(${actual_product_list})
    Lists Should Be Equal  ${actual_product_list}  ${sorted_list}

Products: Assert Sorted: Price (high to low)
    ${actual_product_list}   Products: Get Product Prices
    ${sorted_list}  Evaluate  sorted(${actual_product_list}, reverse=True)
    Lists Should Be Equal  ${actual_product_list}  ${sorted_list}
