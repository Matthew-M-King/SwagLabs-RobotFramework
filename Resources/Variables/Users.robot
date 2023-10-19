*** Variables ***
${default_username}  standard_user
${default_password}  secret_sauce
${user_data_string}  
...  {
...      "standard_user": 
...      {
...          "username": "standard_user",
...          "password": "secret_sauce",
...          "firstname": "Archibald",
...          "lastname": "Archives",
...          "zip": "ZIP123"
...      },
...      "locked_out_user": 
...      {
...          "username": "locked_out_user",
...          "password": "secret_sauce"
...      },
...      "problem_user": 
...      {
...          "username": "problem_user",
...          "password": "secret_sauce",
...          "firstname": "Archibald",
...          "lastname": "Archives",
...          "zip": "ZIP123"
...      },
...      "visual_user":
...      {
...          "username": "visual_user",
...          "password": "secret_sauce",
...          "firstname": "Archibald",
...          "lastname": "Archives",
...          "zip": "ZIP123"
...      },
...      "performance_glitch_user": 
...      {
...          "username": "performance_glitch_user",
...          "password": "secret_sauce",
...          "firstname": "Archibald",
...          "lastname": "Archives",
...          "zip": "ZIP123"
...      },
...      "missing_password": 
...      {
...          "username": "missing_password",
...          "password": "${EMPTY}"
...      },
...      "missing_username": 
...      {
...          "username": "${EMPTY}",
...          "password": "secret_sauce"
...      },
...      "missing_user_and_pass": 
...      {
...          "username": "${EMPTY}",
...          "password": "${EMPTY}"
...      },
...      "invalid_password": 
...      {
...          "username": "standard_user",
...          "password": "incorrect"
...      },
...      "unknown_user": 
...      {
...          "username": "unknown_user",
...          "password": "secret_sauce"
...      }
...  }
