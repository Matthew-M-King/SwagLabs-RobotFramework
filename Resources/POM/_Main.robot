*** Settings ***
Library    SeleniumLibrary
Library    Collections


*** Variables ***
${locator_header_lbl}    //div[@class="header_label"]
${locator_cart_link}     //a[@class="shopping_cart_link"]
${locator_cart_badge}    //span[@class="shopping_cart_badge"]
${locator_app_logo}      //div[@class="app_logo"]
${locator_menu}          id=react-burger-menu-btn
&{locators_menu_item_map}
...    All Items=id=inventory_sidebar_link
...    About=id=about_sidebar_link
...    Logout=id=logout_sidebar_link
...    Reset App State=reset_sidebar_link



*** Keywords ***
Try Assert
    [Arguments]    ${assertion}    @{arguments}    &{kwargs}
    ${status}    ${message_or_value}=    Run Keyword And Ignore Error    ${assertion}    @{arguments}    &{kwargs}
    Return From Keyword If   '${status}'=='PASS'   ${message_or_value}
    Append To List  ${multi_failure_tracker}  ${message_or_value}

Main: Go To Page
    [Arguments]   ${page}
    Go To    ${page_mapping}[Main]${page_mapping}[${page}]

Main: Tab to Page
    [Arguments]   ${page}
    Execute Javascript   window.open('${page_mapping}[Main]${page_mapping}[${page}]');
    Main: Switch To Next Tab

Main: Switch To Next Tab
    ${all_handles}   Get Window Handles
    ${handle_index}  Evaluate       ${current_handle_index}+1
    Set Test Variable   ${current_handle_index}  ${handle_index}
    Switch Window    ${all_handles}[${current_handle_index}]

Main: Switch To Previous Tab
    ${all_handles}   Get Window Handles
    ${handle_index}  Evaluate    ${current_handle_index}-1
    Set Test Variable   ${current_handle_index}   ${handle_index}
    Switch Window    ${all_handles}[${current_handle_index}]

Main: Click Cart
    Click Element   ${locator_cart_link}

Main: Assert Basket Count
    [Arguments]  ${expected_count}
    Run Keyword If  ${expected_count} > 0   Element Text Should Be    ${locator_cart_badge}  ${expected_count}
    ...  ELSE  Element Should Not Be Visible   ${locator_cart_badge}

Main: Assert Element Fully Inside Container Element
    [Arguments]  ${parent_locator}  ${child_locator}
    ${parent_x}  ${parent_y}  ${parent_width}  ${parent_height}   Main: Get Element Bounding Box  ${parent_locator}
    ${child_x}   ${child_y}   ${child_width}   ${child_height}    Main: Get Element Bounding Box  ${child_locator}

    ${is_left_inside}   Evaluate  ${child_x} >= ${parent_x}
    ${is_right_inside}  Evaluate  ${child_x} + ${child_width} <= ${parent_x} + ${parent_width}

    ${is_top_inside}     Evaluate  ${child_y} >= ${parent_y}
    ${is_bottom_inside}  Evaluate  ${child_y} + ${child_height} <= ${parent_y} + ${parent_height}
    ${is_fully_inside}   Evaluate  ${is_left_inside} and ${is_right_inside} and ${is_top_inside} and ${is_bottom_inside}
    Should Be True    ${is_fully_inside}==${TRUE}
    ...  msg=Child locator was not fully inside the parent locator boundary\n${parent_locator}\n${child_locator}

Main: Get Element Bounding Box
    [Arguments]  ${locator}
    ${x}  Get Horizontal Position    ${locator}
    ${y}  Get Vertical Position      ${locator}
    ${width}  ${height}    Get Element Size  ${locator}
    Return From Keyword  ${x}  ${y}  ${width}  ${height}
