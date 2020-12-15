*** Settings ***
Library     XMLValidate

*** Keywords ***
Validate response
    [Arguments]                     ${xml_response}         ${xsd_path}
    ${response}                     Element To String       ${xml_response}
    Xml Validate                    ${response}             ${xsd_path}
