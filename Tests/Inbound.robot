*** Settings ***
Documentation  Parnter method test example

Library     RequestsLibrary

Resource    ../../Resources/Movement/Inbound.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create inbound
    When Put inbound into  ${partner}
    Then Inbound Exist in  ${partner}