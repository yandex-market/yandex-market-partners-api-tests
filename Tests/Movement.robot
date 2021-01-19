*** Settings ***
Documentation  Parnter method test example

Library     RequestsLibrary

Resource    ../../Resources/Common/Movement.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create movement
    Put Movement into  ${partner}


Create and get movement
    Given Put Movement into  ${partner}
    Then Movement Exist in  ${partner}


Create and check status
    Given Put Movement into  ${partner}
    Then Movement Status Is Created in  ${partner}


Create and check history
    Given Put Movement into  ${partner}
    Then Movement Status History Is Correct in  ${partner}


Create movement registry
    Given Put Movement into  ${partner}
    Then Put ds movement registry into  ${partner}
