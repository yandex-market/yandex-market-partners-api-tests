*** Settings ***
Library     DateTimeFormat

*** Keywords ***
Generate Datetime
    [Arguments]         ${in_time}
    ${datetime}         Get Time          time_=${in_time}
    ${datetime}         Convert Time      ${datetime}
    [Return]            ${datetime}


Create DateTime Interval
    [Arguments]         ${left}             ${right}
    ${left_datetime}    Generate Datetime   ${left}
    ${right_datetime}   Generate Datetime   ${right}
    [Return]            ${left_datetime}/${right_datetime}