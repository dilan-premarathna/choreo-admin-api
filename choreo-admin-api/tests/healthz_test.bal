// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerina/http;

http:Client testHealthClient = check new ("http://localhost:9093");

@test:Config {}
function testLiveness() returns error? {
    http:Response response = check testHealthClient->get("/liveness");
    test:assertEquals(response.statusCode, http:STATUS_OK);
}

@test:Config {}
function testReadiness() returns error? {
    http:Response response = check testHealthClient->get("/readiness");
    test:assertEquals(response.statusCode, http:STATUS_OK);
}
