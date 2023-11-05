*** Settings ***
Library    Collections
Resource   ../POM/_Main.robot
Resource   ../POM/ProductListingPage.robot
Resource   ../POM/ProductDetailsPage.robot
Variables  ../Fixtures/Users.yml
Variables  ../Fixtures/ProductDetails.yml


*** Keywords ***
### GIVEN ###
the following number of products in the basket: ${amount}
    Products: Add Number Of Products To Basket  ${amount}
    Set Test Variable  ${current_product_amount}   ${amount}

products have been viewed
    ${details}  Products: Get Product Details
    Set Test Variable  ${current_product_details}  ${details}

some products have been removed from the basket
    Products: Remove Subset

there are ${type:(minimum|maximum|some|no)?} products in the basket
    ${amount}  Products: Work Out Amount  ${type}
    Products: Add Number Of Products To Basket  ${amount}
    Set Test Variable  ${current_product_amount}   ${amount}

there are ${type:(minimum|maximum|some|no)?} products in the basket added from product details
    ${amount}  Products: Work Out Amount  ${type}
    Products: Add Number Of Products To Basket  ${amount}   from_details_page=${TRUE}
    Set Test Variable  ${current_product_amount}   ${amount}

### WHEN ###
${r:(user )?}views products
    ${details}  Products: Get Product Details
    Set Test Variable  ${current_product_details}  ${details}

${r:(user )?}adds the following number of products to the basket: ${amount}
    Products: Add Number Of Products To Basket  ${amount}
    Set Test Variable  ${current_product_amount}   ${amount}

${r:(user )?}removes some products from the basket
    Products: Remove Subset

${r:(user )?}removes some products from the basket in details view
    Products: Remove Subset  from_details_view=${TRUE}

${r:(user )?}removes all products from the basket
    Products: Remove Number Of Products From Basket    ${current_product_amount}
    Set Test Variable    ${current_product_amount}    0

${r:(user )?}sorts products by: ${sort_option}
    Products: Sort   ${sort_option}
    Set Test Variable  ${current_sort_option}   ${sort_option}

${r:(user )?}looks at each product in detail
    FOR  ${product}  IN  @{ProductDetails}
        Products: Click Product Name Link   ${product}
        Try Assert  ProductDetails: Assert Name         ${product}
        Try Assert  ProductDetails: Assert Price        ${product}  ${ProductDetails}[${product}][price]
        Try Assert  ProductDetails: Assert Desc         ${product}  ${ProductDetails}[${product}][desc]
        Try Assert  ProductDetails: Assert Image        ${product}  ${ProductDetails}[${product}][image]
        Products: Click Back To Products
    END

### THEN ###
the products should be sorted
    Run Keyword  Products: Assert Sorted: ${current_sort_option}

the listed products should be correct
    FOR  ${product}  IN  @{ProductDetails}
        Should Be Equal As Strings
        ...  ${ProductDetails}[${product}][price]
        ...  ${current_product_details}[${product}][price]
        ...  msg=Price doesn't match for product: ${product}
        Should Contain
        ...    ${current_product_details}[${product}][desc]
        ...    ${ProductDetails}[${product}][desc]
        Should Be Equal As Strings
        ...  ${Urls}[BaseUrl]${ProductDetails}[${product}][image]
        ...  ${current_product_details}[${product}][image]
        ...  msg=Image doesn't match for product: ${product}\n
    END

each product details page should be correct
    IF  ${multi_failure_tracker}
        Log List    ${multi_failure_tracker}
        Fail  There were failures. See logs
    END

details of products should be aligned correctly within their box
    ${products}  Products: Get
    FOR  ${index}  ${product}  IN ENUMERATE  @{products}
        ${index}  Evaluate  ${index}+1
        Try Assert  Main: Assert Element Fully Inside Container Element  
        ...  ${locator_products}\[${index}]   ${locator_products}\[${index}]${locator_btn_add_cart}
        Try Assert  Main: Assert Element Fully Inside Container Element  
        ...  ${locator_products}\[${index}]   ${locator_products}\[${index}]${locator_inventory_item_name}
        Try Assert  Main: Assert Element Fully Inside Container Element  
        ...  ${locator_products}\[${index}]   ${locator_products}\[${index}]${locator_inventory_item_desc}
        Try Assert  Main: Assert Element Fully Inside Container Element  
        ...  ${locator_products}\[${index}]   ${locator_products}\[${index}]${locator_inventory_item_price}
        Try Assert  Main: Assert Element Fully Inside Container Element  
        ...  ${locator_products}\[${index}]   ${locator_products}\[${index}]${locator_inventory_item_image}
    END
    IF  ${multi_failure_tracker}
        Capture Page Screenshot
        Log List    ${multi_failure_tracker}
        Fail  There were failures. See logs.
    END
