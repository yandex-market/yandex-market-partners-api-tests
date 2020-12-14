*** Settings ***
Library     XML
Library     RequestsLibrary
Library     String
Library     XMLValidate

Resource    ../Requests.robot

*** Keywords ***
Set partner id into
    [Arguments]         ${xml_request}      ${id}   ${xpath}
    Set Element Text    ${xml_request}      ${id}   xpath=${xpath}/partnerId
    Set Element Text    ${xml_request}      ${id}   xpath=${xpath}/deliveryId


Get partner id from
    [Arguments]     ${xml_response}         ${xpath}
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
    ${xml_request}                  Parse xml           Data/Requests/Orders/Delivery/get_orders_status.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/ordersId/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/ordersId/orderId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_orders_status}
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/orderStatusHistories/orderStatusHistory/orderId

    Element Text Should Be          ${xml_response}     ${status}       message=${message}
    ...                             xpath=response/orderStatusHistories/orderStatusHistory/history/orderStatus/statusCode


Get order from
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Orders/Delivery/get_order.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/orderId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.get_order}
    [Return]                        ${xml_response}


Validate response
    [Arguments]                     ${xml_response}         ${xsd_path}
    ${response}                     Element To String       ${xml_response}
    Xml Validate                    ${response}             ${xsd_path}


#-----------------------------------------------------------------------------------------------------------------------
Created order in
    [Arguments]                     ${partner}
    ${YANDEX_ID}                    Generate Random String  7  [NUMBERS]

    ${xml_request}                  Parse xml               Data/Requests/Orders/Delivery/create_order.xml
    Set Element Text                ${xml_request}          ${YANDEX_ID}        xpath=request/order/orderId/yandexId
    ${NEW_ORDER}                    Get Element             ${xml_request}      xpath=request/order
    ${delivery_date}                Get Time                time_=NOW + 1day
    Set Element Text                ${xml_request}          ${delivery_date}        xpath=request/order/deliveryDate
    Set Element Text                ${xml_request}          ${delivery_date}        xpath=request/order/shipmentDate

    ${xml_response}                 Send xml request        ${xml_request}      ${partner.urls.create_order}
    Validate response               ${xml_response}         Data/Responses/Delivery/Orders/create_order_response.xsd
    Check errors not exist from     ${xml_response}
    Element Text Should Be          ${xml_response}         ${YANDEX_ID}        xpath=response/orderId/yandexId

    ${PARTNER_ID}                   Get partner id from     ${xml_response}     response/orderId
    Set Test Variable               ${YANDEX_ID}
    Set Test Variable               ${PARTNER_ID}
    Set Test Variable               ${NEW_ORDER}


Order exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get order from      ${partner}
    Validate response               ${xml_response}     Data/Responses/Delivery/Orders/get_order_response.xsd
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/order/orderId
    [Return]                        ${xml_response}


Was cancelled order from
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Orders/Delivery/cancel_order.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/orderId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.cancel_order}
    Validate response               ${xml_response}     Data/Responses/Delivery/Orders/cancel_order_response.xsd
    Check errors not exist from     ${xml_response}


Order did not exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get order from      ${partner}
    Validate response               ${xml_response}     Data/Responses/Delivery/Orders/get_order_response.xsd
    Run Keyword And Expect Error    *   Check errors not exist from     ${xml_response}


Order status is canceled in
    [Arguments]                     ${partner}
    Check order status in           ${partner}          410             Order was not canceled


Remove order item from
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Orders/Delivery/update_order_items.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/orderId

    ${xml_response}                 Send xml request    ${xml_request}  ${partner.urls.update_order_items}
    Validate response               ${xml_response}     Data/Responses/Delivery/Orders/update_order_items_response.xsd
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/orderId


Order item was removed from
    [Arguments]                     ${partner}
    ${xml_response}                 Order exist in      ${partner}
    ${begin_items_count}            Get Element Count   ${NEW_ORDER}        xpath=items/item
    ${end_items_count}              Get Element Count   ${xml_response}     xpath=response/order/items/item
    Should Be True                  ${${begin_items_count}-1} == ${end_items_count}
