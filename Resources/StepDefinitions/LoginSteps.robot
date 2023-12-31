*** Settings ***
Resource    ../POM/LoginPage.robot
Variables   ../Fixtures/Users.yml


*** Keywords ***
### GIVEN ###
user "${user}" is logged in
    Login: Perform User Login    ${Users}[${user}][username]   ${Users}[${user}][password]

### WHEN ###
${r:(user )?}tries to login as "${user}" user
    Login: Perform User Login    ${Users}[${user}][username]   ${Users}[${user}][password]

${r:(user )?}logs back in
    Login: Perform User Login    ${default_username}   ${default_password}

### THEN ###
error message related to "${msg_type}" user should be displayed
    Login: Assert Error Message    ${msg_type}