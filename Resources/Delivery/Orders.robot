*** Settings ***
Library     XML
Library     String

Resource    ../Validation.robot
Resource    Helpers.robot


*** Keywords ***
Created order in
    [Arguments]                     ${partner}
    ${YANDEX_ID}                    Generate Random String  7  [NUMBERS]

    ${xml_request}                  Parse xml               Data/Requests/Delivery/create_order.xml
    Set Element Text                ${xml_request}          ${YANDEX_ID}        xpath=request/order/orderId/yandexId
    ${NEW_ORDER}                    Get Element             ${xml_request}      xpath=request/order
    ${delivery_date}                Get Time                time_=NOW + 1day
    Set Element Text                ${xml_request}          ${delivery_date}        xpath=request/order/deliveryDate
    Set Element Text                ${xml_request}          ${delivery_date}        xpath=request/order/shipmentDate

    ${xml_response}                 Send order request      ${xml_request}      ${partner.urls.create_order}
    Validate response               ${xml_response}         Data/Responses/Schemas/Delivery/create_order_response.xsd
    Check errors not exist from     ${xml_response}
    Element Text Should Be          ${xml_response}         ${YANDEX_ID}        xpath=response/orderId/yandexId

    ${PARTNER_ID}                   Get partner id from     ${xml_response}     response/orderId
    Set Test Variable               ${YANDEX_ID}
    Set Test Variable               ${PARTNER_ID}
    Set Test Variable               ${NEW_ORDER}


Order exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get order from      ${partner}
    Validate response               ${xml_response}     Data/Responses/Schemas/Delivery/get_order_response.xsd
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/order/orderId
    [Return]                        ${xml_response}


Was cancelled order from
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Delivery/cancel_order.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/orderId

    ${xml_response}                 Send order request  ${xml_request}  ${partner.urls.cancel_order}
    Validate response               ${xml_response}     Data/Responses/Schemas/Delivery/cancel_order_response.xsd
    Check errors not exist from     ${xml_response}


Order did not exist in
    [Arguments]                     ${partner}
    ${xml_response}                 Get order from      ${partner}
    Validate response               ${xml_response}     Data/Responses/Schemas/Delivery/get_order_response.xsd
    Run Keyword And Expect Error    *   Check errors not exist from     ${xml_response}


Order status is canceled in
    [Arguments]                     ${partner}
    Check order status in           ${partner}          410             Order was not canceled


Remove order item from
    [Arguments]                     ${partner}
    ${xml_request}                  Parse xml           Data/Requests/Delivery/update_order_items.xml
    Set Element Text                ${xml_request}      ${YANDEX_ID}    xpath=request/orderId/yandexId
    Set partner id into             ${xml_request}      ${PARTNER_ID}   request/orderId

    ${xml_response}                 Send order request  ${xml_request}  ${partner.urls.update_order_items}
    Validate response               ${xml_response}     Data/Responses/Schemas/Delivery/update_order_items_response.xsd
    Check errors not exist from     ${xml_response}
    Check partner id in             ${xml_response}     ${PARTNER_ID}   response/orderId


Order item was removed from
    [Arguments]                     ${partner}
    ${xml_response}                 Order exist in      ${partner}
    ${begin_items_count}            Get Element Count   ${NEW_ORDER}        xpath=items/item
    ${end_items_count}              Get Element Count   ${xml_response}     xpath=response/order/items/item
    Should Be True                  ${${begin_items_count}-1} == ${end_items_count}
