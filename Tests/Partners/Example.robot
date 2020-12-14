*** Settings ***
Documentation  Parnter method test example

Variables   ../../Configs/partner_config.yml

Library     RequestsLibrary

Resource    ../../Resources/Partners/Requests.robot

Suite Setup     Create Session  partner  ${partner.host}
Suite Teardown  Delete All Sessions


*** Test Cases ***
Put Inbound test
    When Send putInbound request to  partner
