*** Settings ***
Library     XML
Library     String

Resource    ../Requests.robot


*** Keywords ***
Set partner id into
    [Arguments]         ${xml_request}      ${id}   ${xpath}
    Set Element Text    ${xml_request}      ${id}   xpath=${xpath}/partnerId
    Set Element Text    ${xml_request}      ${id}   xpath=${xpath}/deliveryId


Get partner id from
    [Arguments]     ${xml_response}     ${xpath}
    ${count}        Get Element Count   ${xml_response}     xpath=${xpath}/partnerId
    ${id}           Run Keyword If      ${count}==0         Get Element Text    ${xml_response}     xpath=${xpath}/deliveryId
    ...             ELSE                                    Get Element Text    ${xml_response}     xpath=${xpath}/partnerId

    [Return]        ${id}


Check partner id in
    [Arguments]     ${xml_response}     ${id}               ${xpath}
    ${count}        Get Element Count   ${xml_response}     xpath=${xpath}/partnerId

    Run Keyword If  ${count}==0         Element Text Should Be      ${xml_response}     ${id}   xpath=${xpath}/deliveryId
    ...             ELSE                Element Text Should Be      ${xml_response}     ${id}   xpath=${xpath}/partnerId


Send delivery request
    [Arguments]             ${xml_request}          ${url}
    ${request_id}           Set request id to       ${xml_request}
    ${xml_response}         Send xml request        ${xml_request}  ${url}
    Check response id from  ${xml_response}         ${request_id}
    [Return]                ${xml_response}

