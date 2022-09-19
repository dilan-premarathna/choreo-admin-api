
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerinax/java.jdbc;
import ballerina/sql;
import choreo_admin_api.configs;

@test:Mock {
    functionName: "createJdbcClient"
}
function getMockClient() returns jdbc:Client|sql:Error {

    return test:mock(jdbc:Client);
}

@test:Mock {
    functionName: "createAppDbClient"
}
function getAppDbClient() returns jdbc:Client|sql:Error {

    return test:mock(jdbc:Client);
}

@test:Config {}
function testGetOrgSubsctiptionDetails() {

    test:prepare(dbClient).when("queryRow").thenReturn(subscriptionDAOStream);
    json|error subsDetail = getOrgSubsctiptionDetails("3ac78213-9cd9-b96a-d98cbb16d4cc");
    test:assertEquals(subsDetail, mockSubscription);
}

@test:Config {}
function testUpdateTier() {
    UpdateSubscripionTier subscription = {
        stepQuota: "5000",
        tierName: "Enterprise"
    };

    test:prepare(dbClient).when("execute").thenReturn(mockedUpdateTierResult());
    int|error subsDetail = updateTier("3ac78213-9cd9-b96a-d98cbb16d4cc", subscription);
    test:assertEquals(subsDetail, 0);

}

@test:Config {}
function testCheckAdminRole() {

    test:prepare(appDbClient).when("queryRow").thenReturn("1002");
    boolean|error isAdminUser = checkAdminRole("175cfc46-b124-471c-b8ca-f0fd0a8e87bd", configs:CHOERO_SYS_ORG_UUID);
    test:assertEquals(isAdminUser, true);
}
