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


Check order status in
    [Arguments]                     ${partner}          ${status}       ${message}
    ${xml_request}                  Parse xml           Data/Requests/Delivery/get_orders_status.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/ordersId/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/ordersId/orderId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_orders_status}
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/orderStatusHistories/orderStatusHistory/orderId

    Element Text Should Be          ${xml_response}     ${status}       message=${message}
    ...                             xpath=response/orderStatusHistories/orderStatusHistory/history/orderStatus/statusCode


Get order from
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Delivery/get_order.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/orderId

    ${xml_response}                 Send order request  ${xml_request}  ${partner.urls.get_order}
    [Return]                        ${xml_response}


Send order request
    [Arguments]             ${xml_request}          ${url}
    ${request_id}           Set request id to       ${xml_request}
    ${xml_response}         Send xml request        ${xml_request}  ${url}
    Check response id from  ${xml_response}         ${request_id}
    [Return]                ${xml_response}

