*** Settings ***
Documentation  Parnter method test example

Library     RequestsLibrary

Resource    ../../Resources/Movement/Inbound.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create inbound
    Given Put inbound into  ${partner}
