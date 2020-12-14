*** Settings ***
Documentation  Parnter method test example

Variables   ../../Configs/partner_config.yml

Library     RequestsLibrary

Resource    ../../Resources/Partners/Delivery/Orders.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create and delete order
    Given Created order in  ${partner}
    And Order exist in  ${partner}
    When Was cancelled order from  ${partner}
#    Then Order status is canceled in  ${partner}


Remove order items
    Given Created order in  ${partner}
    And Order exist in  ${partner}
    When Remove order item from  ${partner}
    Then Order item was removed from  ${partner}
