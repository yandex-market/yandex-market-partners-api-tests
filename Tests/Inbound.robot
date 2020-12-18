*** Settings ***
Documentation  Parnter method test example

Library     RequestsLibrary

Resource    ../../Resources/Delivery/Inbound.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create inbound
    When Put inbound into  ${partner}
    Then Inbound Exist in  ${partner}