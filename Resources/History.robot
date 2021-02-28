*** Settings ***
Library     HistoryWriter

*** Keywords ***
Clear History
    Delete history file  ${TEST NAME}


Write request
    [Arguments]             ${url}          ${headers}  ${data}
    Write request to file   ${TEST NAME}    ${url}      ${headers}  ${data}

Write response
    [Arguments]             ${data}
    Write response to file  ${TEST NAME}    ${data}
