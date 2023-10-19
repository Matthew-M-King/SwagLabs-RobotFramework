*** Settings ***
Documentation     Login
...              
...               Tests related to user login
Resource          ../Resources/Setup.robot
Suite Setup       Setup Suite
Suite Teardown    Teardown Suite
Test Teardown     Teardown Test
Test Tags         login


*** Test Cases ***
Scenario: Valid Standard User Login                standard_user
    [Template]   Scenario Outline: Valid User Login

Scenario: Valid Performance Glitched User Login    performance_glitch_user
    [Template]   Scenario Outline: Valid User Login

Scenario: Valid Problem User Login                 problem_user
    [Template]   Scenario Outline: Valid User Login

Scenario: Invalid Locked out User Login            locked_out_user
    [Template]   Scenario Outline: Invalid User Login

Scenario: Invalid Missing Password User Login      missing_password
    [Template]   Scenario Outline: Invalid User Login

Scenario: Invalid Missing Username Login           missing_username
    [Template]   Scenario Outline: Invalid User Login

Scenario: Invalid Missing Username and Password Login   missing_user_and_pass
    [Template]   Scenario Outline: Invalid User Login

Scenario: Invalid Incorrect Password Login         invalid_password
    [Template]   Scenario Outline: Invalid User Login

Scenario: Invalid Unknown User Login               unknown_user
    [Template]   Scenario Outline: Invalid User Login

Scenario: Users on the login page don't have accessability issues
    [Tags]  accessability
     When I check for accessability problems
     Then the page should be accessible


*** Keywords ***
Scenario Outline: Valid User Login
    [Arguments]  ${username}
    When I try to login as "${username}" user
    Then the "ProductInventory" page should be displayed

Scenario Outline: Invalid User Login
    [Arguments]  ${username}
    When I try to login as "${username}" user
    Then the "Login" page should be displayed
     And error message related to "${username}" user should be displayed
