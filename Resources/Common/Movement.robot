*** Settings ***
Library     XML
Library     String

Resource    Helpers.robot
Resource    ../Validation.robot
Resource    ../DateTime.robot


*** Keywords ***
Put movement into
    [Arguments]                     ${partner}
    ${YANDEX_ID}                    Generate Random String      7                   [NUMBERS]
    ${interval}                     Create DateTime Interval    NOW + 1day          NOW + 2day

    ${xml_request}                  Parse xml               Data/Requests/Common/put_movement.xml
    Set Element Text                ${xml_request}          ${YANDEX_ID}        xpath=request/movement/movementId/yandexId
    Set Element Text                ${xml_request}          ${interval}         xpath=request/movement/interval
    ${NEW_MOVEMENT}                 Get Element             ${xml_request}      xpath=request/movement

    ${xml_response}                 Send common request     ${xml_request}      ${partner.urls.put_movement}
    Validate response               ${xml_response}         Data/Schemas/Responses/Common/put_movement_response.xsd
    Check errors not exist from     ${xml_response}

    ${PARTNER_ID}                   Get Element Text        ${xml_response}     xpath=response/movementId/partnerId
    Set Test Variable               ${YANDEX_ID}
    Set Test Variable               ${PARTNER_ID}
    Set Test Variable               ${NEW_MOVEMENT}


Movement Exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get movement from   ${partner}
    Check errors not exist from     ${xml_response}
    Check movement id from          ${xml_response}     response/movement/movementId
    [Return]                        ${xml_response}


Movement status is created in
    [Arguments]                     ${partner}
    Check movement status in        ${partner}          1     Movement was not created


Movement Status History Is Correct in
    [Arguments]                     ${partner}
    Get movement status history in   ${partner}


Put ds movement registry into
    [Arguments]                     ${partner}
    ${REGISTRY_YANDEX_ID}           Generate Random String      7                   [NUMBERS]
    ${registry_date}                Generate datetime           NOW

    ${xml_request}                  Parse xml               Data/Requests/Delivery/put_movement_registry.xml
    Set Element Text                ${xml_request}          ${REGISTRY_YANDEX_ID}   xpath=request/registry/registryId/yandexId
    Set Element Text                ${xml_request}          ${YANDEX_ID}            xpath=request/registry/movementId/yandexId
    Set Element Text                ${xml_request}          ${PARTNER_ID}           xpath=request/registry/movementId/partnerId
    Set Element Text                ${xml_request}          ${registry_date}        xpath=request/registry/date

    ${xml_response}                 Send common request     ${xml_request}      ${partner.urls.put_movement_registry}
    Validate response               ${xml_response}         Data/Schemas/Responses/Delivery/put_movement_registry_response.xsd
    Check errors not exist from     ${xml_response}

    ${REGISTRY_PARTNER_ID}          Get Element Text        ${xml_response}     xpath=response/registryId/partnerId
    Set Test Variable               ${REGISTRY_YANDEX_ID}
    Set Test Variable               ${REGISTRY_PARTNER_ID}

##-----------------------------------------------------------------------------------------------------------------------
Get movement from
    [Arguments]                 ${partner}
    ${xml_request}              Parse xml               Data/Requests/Common/get_movement.xml
    Set Element Text            ${xml_request}          ${YANDEX_ID}    xpath=request/movementId/yandexId
    Set Element Text            ${xml_request}          ${PARTNER_ID}   xpath=request/movementId/partnerId

    ${xml_response}             Send common request     ${xml_request}  ${partner.urls.get_movement}

    Validate response           ${xml_response}         Data/Schemas/Responses/Delivery/get_movement_response.xsd
    [Return]                    ${xml_response}


Check movement id from
    [Arguments]                 ${xml_response}     ${xpath}
    Element Text Should Be      ${xml_response}     ${YANDEX_ID}    xpath=${xpath}/yandexId
    Element Text Should Be      ${xml_response}     ${PARTNER_ID}   xpath=${xpath}/partnerId


Check movement status in
    [Arguments]                     ${partner}          ${status}       ${message}
    ${xml_request}                  Parse xml           Data/Requests/Common/get_movement_status.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/movementIds/movementId/yandexId
    Set Element Text                ${xml_request}      ${PARTNER_ID}   xpath=request/movementIds/movementId/partnerId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_movement_status}
    Validate response               ${xml_response}     Data/Schemas/Responses/Common/get_movement_status_response.xsd
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/movementStatuses/movementStatus/movementId

    Element Text Should Be          ${xml_response}     ${status}       message=${message}
    ...                             xpath=response/movementStatuses/movementStatus/status/statusCode


Get movement status history in
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Common/get_movement_status_history.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/movementIds/movementId/yandexId
    Set Element Text                ${xml_request}      ${PARTNER_ID}   xpath=request/movementIds/movementId/partnerId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_movement_status_history}
    Validate response               ${xml_response}     Data/Schemas/Responses/Common/get_movement_status_history_response.xsd
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/movementStatusHistories/movementStatusHistory/movementId
