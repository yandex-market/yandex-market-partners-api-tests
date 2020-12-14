*** Settings ***
Library     XML
Library     RequestsLibrary
Library     Request

*** Keywords ***
Send xml request
    [Arguments]         ${xml_request}          ${url}

    ${request_id}       Set request id to       ${xml_request}
    Set Element Text    ${xml_request}          ${partner.token}    xpath=token

    &{headers}          Create Dictionary       Content-Type=text/xml

    ${request}          Element To String       ${xml_request}
    log                 ${request}              info

    ${is_exist}         Session Exists          ${url}
    Run Keyword Unless  ${is_exist}             Create Session  ${url}  ${url}
    ${response}         Post On Session         ${url}  /  data=${request.encode('utf-8')}  headers=${headers}
    log                 ${response.text}        info

    ${xml_response}     Parse xml               ${response.text}

    ${request_type}     Get Element Attribute   ${xml_request}      type            xpath=request
    ${response_type}    Get Element Attribute   ${xml_response}     type            xpath=response
    Should Be Equal As Strings  ${request_type}  ${response_type}   The request type is not equal to the response type

    Check response id from      ${xml_response}  ${request_id}

    [Return]            ${xml_response}


Check errors not exist from
    [Arguments]             ${xml_response}
    ${error}                Element To String   ${xml_response}     xpath=requestState
    Element Text Should Be  ${xml_response}     false               xpath=requestState/isError       message=${error}


Set request id to
    [Arguments]             ${xml_request}
    ${uniq}                 generate unique
    Set Element Text        ${xml_request}          ${uniq}         xpath=uniq
    Set Element Text        ${xml_request}          ${uniq}         xpath=hash
    [Return]                ${uniq}


Check response id from
    [Arguments]             ${xml_response}         ${request_id}
    ${count}                Get Element Count       ${xml_response}             xpath=uniq

    Run Keyword If          ${count}==0             Check hash from response    ${xml_response}     ${request_id}
    ...                     ELSE                    Check uniq from response    ${xml_response}     ${request_id}


Check uniq from response
    [Arguments]             ${xml_response}         ${request_uniq}
    ${response_uniq}        Get Element Text        ${xml_response}     xpath=uniq
    Should Be Equal As Strings  ${request_uniq}  ${response_uniq}   The request uniq is not equal to the response uniq


Check hash from response
    [Arguments]             ${xml_response}         ${request_hash}
    ${response_hash}        Get Element Text        ${xml_response}     xpath=hash
    Should Be Equal As Strings  ${request_hash}  ${response_hash}   The request hash is not equal to the response hash

