*** Settings ***
Variables  ../Fixtures/Urls.yml
Resource  ../POM/_Main.robot
Library   ../Custom/WriteMultiFailureResult.py
Library    SeleniumLibrary
Library    AxeLibrary


*** Keywords ***
### GIVEN ###
there isn't any products in the basket
    Execute JavaScript   localStorage.clear();
    Reload Page

the ${page} page is open on a new tab
    Main: Tab to Page    ${page}

the "${page}" page is displayed
    Main: Go To Page    ${page}

the session has timed out
    Delete All Cookies
    Reload Page

the basket contents are displayed
    Main: Click Cart

### WHEN ###
${r:(user )?}views the basket contents
    Main: Click Cart

${r:(user )?}switches to the previous tab
    Main: Switch To Previous Tab

${r:(user )?}moves to the "${page}" page
    Main: Go To Page    ${page}

${r:(user )?}checks for accessability problems
    &{results}=    Run Accessibility Tests    AxeResults.json
    Set Test Variable  ${current_axe_results}   ${results}

${r:(user )?}checks the position of the shopping cart icon
    Try Assert  Main: Assert Element Fully Inside Container Element   
    ...    ${locator_header_lbl}   ${locator_cart_link}

${r:(user )?}checks the position of the menu icon
    Try Assert  Main: Assert Element Fully Inside Container Element   
    ...    ${locator_header_lbl}   ${locator_menu}

${r:(user )?}checks the position of the main title
    Try Assert  Main: Assert Element Fully Inside Container Element   
    ...    ${locator_header_lbl}   ${locator_app_logo}

### THEN ###
the "${page}" page should be displayed
    IF   "${page}"=="Main" or "${page}"=="Login"
        ${expected_page}  Set Variable   ${Urls}[BaseUrl]
    ELSE
        ${expected_page}  Catenate   ${Urls}[BaseUrl]${Urls}[${page}]
    END
    ${actual_page}  Get Location
    Should Be Equal As Strings    ${expected_page}    ${actual_page}

basket should indicate correct product count
    Main: Assert Basket Count    ${current_product_amount}

basket shouldn't indicate a product count
    Main: Assert Basket Count    ${current_product_amount}

the page should be accessible
    Log   Violations Count: ${current_axe_results.violations}
    Log Readable Accessibility Result    violations
    IF   ${current_axe_results.violations}
        Fail  Accessability check failed. See log.
    END

the position of each element should be correct
    Return From Keyword If  not ${multi_failure_tracker}
    Log Readable Element Position Failure Result    ${multi_failure_tracker}
    Fail  Element Positioning check(s) failed. See log.