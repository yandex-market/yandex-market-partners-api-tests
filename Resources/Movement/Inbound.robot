*** Settings ***
Library     XML
Library     RequestsLibrary
Library     String

Resource    ../Validation.robot
Resource    ../Times.robot
Resource    Helpers.robot


*** Keywords ***
Put inbound into
    [Arguments]                     ${partner}
    ${YANDEX_ID}                    Generate Random String  7  [NUMBERS]
    ${interval}                     Create interval         NOW + 1day          NOW + 2day

    ${xml_request}                  Parse xml               Data/Requests/Movement/put_inbound.xml
    Set Element Text                ${xml_request}          ${YANDEX_ID}        xpath=request/inbound/inboundId/yandexId
    Set Element Text                ${xml_request}          ${interval}         xpath=request/inbound/interval
    ${NEW_INBOUND}                  Get Element             ${xml_request}      xpath=request/inbound

    ${xml_response}                 Send movement request   ${xml_request}      ${partner.urls.put_inbound}
    Validate response               ${xml_response}         Data/Responses/Schemas/Movement/put_inbound_response.xsd
    Check errors not exist from     ${xml_response}

    ${PARTNER_ID}                   Get Element Text        ${xml_response}     xpath=response/inboundId/partnerId
    Set Test Variable               ${YANDEX_ID}
    Set Test Variable               ${PARTNER_ID}
    Set Test Variable               ${NEW_INBOUND}
