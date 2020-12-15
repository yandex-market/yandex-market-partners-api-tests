*** Settings ***
Library     XML
Library     String

Resource    ../Requests.robot


*** Keywords ***
Send movement request
    [Arguments]                 ${xml_request}          ${url}
    ${request_id}               Set only uniq to        ${xml_request}
    ${xml_response}             Send xml request        ${xml_request}  ${url}
    Check uniq from response    ${xml_response}         ${request_id}
    [Return]                    ${xml_response}

