*** Settings ***
Library     XML
Library     RequestsLibrary
Library     String
Library     XMLValidate

Resource    ../Requests.robot
Resource    Helpers.robot


*** Keywords ***
Put inbound into
    [Arguments]                     ${partner}

    ${xml_request}                  Parse xml               Data/Requests/Movement/put_inbound.xml

    ${xml_response}                 Send movement request   ${xml_request}      ${partner.urls.put_inbound}
#    Validate response               ${xml_response}         Common/Responses/Schemas/Delivery/create_order_response.xsd
    Check errors not exist from     ${xml_response}
    Element Text Should Be          ${xml_response}         ${YANDEX_ID}        xpath=response/orderId/yandexId
