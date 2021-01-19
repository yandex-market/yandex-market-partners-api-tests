*** Settings ***
Documentation  Parnter method test example

Library     RequestsLibrary

Resource    ../../Resources/Common/Outbound.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create outbound
    Put Outbound into  ${partner}


Create and get outbound
    Given Put Outbound into  ${partner}
    Then Outbound Exist in  ${partner}


Create and check status
    Given Put Outbound into  ${partner}
    Then Outbound Status Is Created in  ${partner}


Create and check history
    Given Put Outbound into  ${partner}
    Then Outbound Status History Is Correct in  ${partner}


Create outbound registry
    Given Put Outbound into  ${partner}
    Then Put ds outbound registry into  ${partner}
