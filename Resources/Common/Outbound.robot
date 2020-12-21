*** Settings ***
Library     XML
Library     String

Resource    Helpers.robot
Resource    ../Validation.robot
Resource    ../DateTime.robot


*** Keywords ***
Put outbound into
    [Arguments]                     ${partner}
    ${YANDEX_ID}                    Generate Random String      7                   [NUMBERS]
    ${interval}                     Create DateTime Interval    NOW + 1day          NOW + 2day

    ${xml_request}                  Parse xml               Data/Requests/Common/put_outbound.xml
    Set Element Text                ${xml_request}          ${YANDEX_ID}        xpath=request/outbound/outboundId/yandexId
    Set Element Text                ${xml_request}          ${interval}         xpath=request/outbound/interval
    ${NEW_INBOUND}                  Get Element             ${xml_request}      xpath=request/outbound

    ${xml_response}                 Send common request     ${xml_request}      ${partner.urls.put_outbound}
    Validate response               ${xml_response}         Data/Schemas/Responses/Common/put_outbound_response.xsd
    Check errors not exist from     ${xml_response}

    ${PARTNER_ID}                   Get Element Text        ${xml_response}     xpath=response/outboundId/partnerId
    Set Test Variable               ${YANDEX_ID}
    Set Test Variable               ${PARTNER_ID}
    Set Test Variable               ${NEW_INBOUND}


Outbound Exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get outbound from   ${partner}
    Check errors not exist from     ${xml_response}
    Check outbound id from          ${xml_response}     response/outbound/outboundId
    [Return]                        ${xml_response}


#Inbound status is created in
#    [Arguments]                     ${partner}
#    Check inbound status in         ${partner}          1     Inbound was not created
#
#
#Inbound Status History Is Correct in
#    [Arguments]                     ${partner}
#    Get inbound status history in   ${partner}
#
##-----------------------------------------------------------------------------------------------------------------------
Get outbound from
    [Arguments]                 ${partner}
    ${xml_request}              Parse xml               Data/Requests/Common/get_outbound.xml
    Set Element Text            ${xml_request}          ${YANDEX_ID}    xpath=request/outboundId/yandexId
    Set Element Text            ${xml_request}          ${PARTNER_ID}   xpath=request/outboundId/partnerId

    ${xml_response}             Send common request     ${xml_request}  ${partner.urls.get_outbound}

    Validate response           ${xml_response}         Data/Schemas/Responses/Delivery/get_outbound_response.xsd
    [Return]                    ${xml_response}


Check outbound id from
    [Arguments]                 ${xml_response}     ${xpath}
    Element Text Should Be      ${xml_response}     ${YANDEX_ID}    xpath=${xpath}/yandexId
    Element Text Should Be      ${xml_response}     ${PARTNER_ID}   xpath=${xpath}/partnerId


#Check inbound status in
#    [Arguments]                     ${partner}          ${status}       ${message}
#    ${xml_request}                  Parse xml           Data/Requests/Common/get_inbound_status.xml
#    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/inboundIds/inboundId/yandexId
#    Set Element Text                ${xml_request}      ${PARTNER_ID}   xpath=request/inboundIds/inboundId/partnerId
#
#    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_inbound_status}
#    Validate response               ${xml_response}     Data/Schemas/Responses/Common/get_inbound_status_response.xsd
#    Check errors not exist from     ${xml_response}
#    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/inboundStatuses/inboundStatus/inboundId
#
#    Element Text Should Be          ${xml_response}     ${status}       message=${message}
#    ...                             xpath=response/inboundStatuses/inboundStatus/status/statusCode
#
#
#Get inbound status history in
#    [Arguments]                     ${partner}
#    ${xml_request}                  Parse xml           Data/Requests/Common/get_inbound_status_history.xml
#    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/inboundIds/inboundId/yandexId
#    Set Element Text                ${xml_request}      ${PARTNER_ID}   xpath=request/inboundIds/inboundId/partnerId
#
#    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_inbound_status_history}
#    Validate response               ${xml_response}     Data/Schemas/Responses/Common/get_inbound_status_history_response.xsd
#    Check errors not exist from     ${xml_response}
#    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/inboundStatusHistories/inboundStatusHistory/inboundId
