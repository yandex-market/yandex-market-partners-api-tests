*** Settings ***


*** Keywords ***
Create interval
    [Arguments]     ${from}         ${to}
    ${from_date}    Get Time        time_=${from}
    ${to_date}      Get Time        time_=${to}
    [Return]                        ${from_date}/${to_date}
