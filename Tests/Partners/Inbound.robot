*** Settings ***
Documentation  Parnter method test example

Variables   ../../Configs/partner_config.yml

Library     RequestsLibrary

Resource    ../../Resources/Partners/Delivery/Orders.robot

Test Teardown  Delete All Sessions


*** Test Cases ***
Create inbound
