// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerina/http;

http:Client testClient = check new ("http://localhost:9090/orgs");

@test:Mock {
    moduleName: "choreo_admin_api.dao",
    functionName: "getOrgSubsctiptionDetails"
}
test:MockFunction mockGetOrgSubsctiptionDetails = new ();

@test:Mock {
    moduleName: "choreo_admin_api.dao",
    functionName: "updateTier"
}
test:MockFunction mockUpdateTier = new ();

@test:Config {}
function testGetSubscriptionOfOrgService() returns error? {
    test:when(mockGetOrgSubsctiptionDetails).thenReturn(mockSubscription);
    http:Response response = check testClient->get("/subscription/1234");
    test:assertEquals(response.statusCode, 200);
}

// @test:Config {
//     dependsOn: [testGetSubscriptionOfOrgService]
// }
// function testGetSubscriptionOfOrgServiceError() returns error? {
//     test:when(mockGetOnPremKeySubscription).thenReturn(error(""));
//     http:Response response = check testClient->get("/subscription/1234");
//     test:assertEquals(response.statusCode, 500);
// }

@test:Config {}
function testUpdateOnTierService() returns error? {
    test:when(mockUpdateTier).thenReturn(0);
    test:when(mockGetOrgSubsctiptionDetails).thenReturn(mockSubscription);
    http:Response response = check testClient->put("/subscription/12345", {
        "stepQuota": "5000",
        "tierName": "Enterprise"
    });
    test:assertEquals(response.statusCode, 200);
}

// @test:Config {
//     dependsOn: [testUpdateOnPremKeyService]
// }
// function testUpdateOnPremKeyServiceError() returns error? {
//     test:when(mockUpdateOnPremKeySubscription).thenReturn(error(""));
//     http:Response response = check testClient->put("/subscriptions/onprem/12345", {
//         "plan": "COMMERCIAL",
//         "startDate": "2022-02-28",
//         "endDate": "2023-02-25"
//     });
//     test:assertEquals(response.statusCode, 500);
// }
