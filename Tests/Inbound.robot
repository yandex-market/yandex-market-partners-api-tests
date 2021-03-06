*** Settings ***
Documentation   Testing inbound methods

Library     RequestsLibrary

Resource    ../../Resources/Common/Inbound.robot
Resource    ../../Resources/History.robot

Test Setup     Clear History
Test Teardown  Delete All Sessions


*** Test Cases ***
Create inbound
    Put Inbound into  ${partner}


Create and get inbound
    Given Put Inbound into  ${partner}
    Then Inbound Exist in  ${partner}


Create and check status
    Given Put Inbound into  ${partner}
    Then Inbound Status Is Created in  ${partner}


Create and check history
    Given Put Inbound into  ${partner}
    Then Inbound Status History Is Correct in  ${partner}


Create inbound registry
    Given Put Inbound into  ${partner}
    Then Put ds inbound registry into  ${partner}
