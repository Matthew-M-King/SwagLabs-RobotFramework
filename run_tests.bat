:: Run tests without "login" tags and set custom output file names
robot --log NONE --report NONE --name "Swaglabs - Standard User Testing" -v default_username:standard_user -e login -o output_standard_user.xml .
robot --log NONE --report NONE --name "Swaglabs - Problem User Testing" -v default_username:problem_user -e login -o output_problem_user.xml .

:: Run only "login" tagged tests with a different output file
robot --log NONE --report NONE --name "Swaglabs - Login & Authentication" -v default_username:standard_user -i login -o output_login_tests.xml .

:: First combine all the individual output files
rebot --name "SwagLabs Test Results" --output combined_output.xml output_standard_user.xml output_problem_user.xml output_login_tests.xml

:: Then generate the final report and log based on the combined output
rebot --output combined_output.xml --report combined_report.html --log combined_log.html