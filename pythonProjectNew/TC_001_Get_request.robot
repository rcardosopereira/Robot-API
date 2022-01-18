*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections

*** Variables ***
${Base_URL}  https://www.anapioficeandfire.com/


*** Test Cases ***
TEST1
   ${response.status_code}=     GET  https://www.anapioficeandfire.com/api/houses   expected_status=200
   ${response.content}=         GET  https://www.anapioficeandfire.com/api/houses
   ${response}=                 GET  https://www.anapioficeandfire.com/api/houses/2
   Should Be Equal As Strings   Dorne       ${response.json()}[region]

TEST2
    Create Session          API_Testing                     ${Base_URL}
    ${Get_Response}=        GET On Session                  API_Testing                 api/houses/2
    ${json_response}=       set variable                    ${Get_Response.json()}
    @{region}               get value from json             ${json_response}            region
    ${r_region}=            get from list                   ${region}                   0
    should be equal         ${r_region}                     Dorne

TEST3
    Create Session          API_Testing                     ${Base_URL}
    ${Get_Response}=        GET On Session                  API_Testing                 api/houses/2
    ${json_object}=         to json                         ${Get_Response.content}
    ${region_Name}=         get value from json             ${json_object}              $.region
    log to console          ${region_Name[0]}

TEST4
    Create Session          Test_API                        https://www.anapioficeandfire.com/
    ${resp_json}=           GET On Session                  Test_API                            api/houses/2
    should be equal         ${resp_json.json()}             Dorne


