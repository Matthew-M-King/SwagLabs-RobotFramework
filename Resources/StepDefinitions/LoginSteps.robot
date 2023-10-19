*** Settings ***
Resource   ../POM/LoginPage.robot
Resource   ../Variables/Users.robot


*** Keywords ***
### GIVEN ###
user "${user}" is logged in
    ${user_map}  Evaluate   ${user_data_string}
    Login: Perform User Login    ${user_map}[${user}][username]   ${user_map}[${user}][password]

### WHEN ###
I try to login as "${user}" user
    ${user_map}  Evaluate   ${user_data_string}
    Login: Perform User Login    ${user_map}[${user}][username]   ${user_map}[${user}][password]

I log back in
    Login: Perform User Login    ${default_username}   ${default_password}

### THEN ###
error message related to "${msg_type}" user should be displayed
    Login: Assert Error Message    ${msg_type}