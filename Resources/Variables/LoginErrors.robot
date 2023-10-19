*** Variables ***
${no_match_credentials}  Username and password do not match any user in this service
&{error_msg_type_maps}
...    locked_out_user=Sorry, this user has been locked out.
...    missing_password=Password is required
...    missing_username=Username is required
...    missing_user_and_pass=Username is required
...    invalid_password=${no_match_credentials}
...    unknown_user=${no_match_credentials}