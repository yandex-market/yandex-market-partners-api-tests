*** Settings ***
Library     XML
Library     String

Resource    Helpers.robot
Resource    ../Validation.robot
Resource    ../DateTime.robot


*** Keywords ***
Put inbound into
    [Arguments]                     ${partner}
    ${YANDEX_ID}                    Generate Random String      7                   [NUMBERS]
    ${interval}                     Create DateTime Interval    NOW + 1day          NOW + 2day

    ${xml_request}                  Parse xml               Data/Requests/Delivery/put_inbound.xml
    Set Element Text                ${xml_request}          ${YANDEX_ID}        xpath=request/inbound/inboundId/yandexId
    Set Element Text                ${xml_request}          ${interval}         xpath=request/inbound/interval
    ${NEW_INBOUND}                  Get Element             ${xml_request}      xpath=request/inbound

    ${xml_response}                 Send delivery request   ${xml_request}      ${partner.urls.put_inbound}
    Validate response               ${xml_response}         Data/Schemas/Responses/Delivery/put_inbound_response.xsd
    Check errors not exist from     ${xml_response}

    ${PARTNER_ID}                   Get Element Text        ${xml_response}     xpath=response/inboundId/partnerId
    Set Test Variable               ${YANDEX_ID}
    Set Test Variable               ${PARTNER_ID}
    Set Test Variable               ${NEW_INBOUND}


Inbound Exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get inbound from    ${partner}
    Validate response               ${xml_response}     Data/Schemas/Responses/Delivery/get_inbound_response.xsd
    Check errors not exist from     ${xml_response}
    Check inboud id from            ${xml_response}     response/inbound/inboundId
    [Return]                        ${xml_response}


#-----------------------------------------------------------------------------------------------------------------------
Get inbound from
    [Arguments]                 ${partner}
    ${xml_request}              Parse xml               Data/Requests/Delivery/get_inbound.xml
    Set Element Text            ${xml_request}          ${YANDEX_ID}    xpath=request/inboundId/yandexId
    Set Element Text            ${xml_request}          ${PARTNER_ID}   xpath=request/inboundId/partnerId

    ${xml_response}             Send delivery request   ${xml_request}  ${partner.urls.get_inbound}
    [Return]                    ${xml_response}


Check inboud id from
    [Arguments]                 ${xml_response}     ${xpath}
    Element Text Should Be      ${xml_response}     ${YANDEX_ID}    xpath=${xpath}/yandexId
    Element Text Should Be      ${xml_response}     ${PARTNER_ID}   xpath=${xpath}/partnerId
