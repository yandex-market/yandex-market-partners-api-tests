*** Settings ***
Library     XML
Library     String

Resource    ../Requests.robot


*** Keywords ***
Check partner id in
    [Arguments]                 ${xml_response}     ${id}   ${xpath}
    Element Text Should Be      ${xml_response}     ${id}   xpath=${xpath}/partnerId


Send common request
    [Arguments]             ${xml_request}          ${url}
    ${request_id}           Set request id to       ${xml_request}
    ${xml_response}         Send xml request        ${xml_request}  ${url}
    Check response id from  ${xml_response}         ${request_id}
    [Return]                ${xml_response}
