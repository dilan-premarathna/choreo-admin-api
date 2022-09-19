// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;

@test:Mock {
    moduleName: "choreo_admin_api.dao",
    functionName: "checkAdminRole"
}
test:MockFunction mockCheckAdminRole = new ();

@test:Config {}
function testGetSubscriptionOfOrgService() returns error? {
    string idpID = check getIdpID(mockJWT);
    test:assertEquals(mockIDPID, idpID);
}

@test:Config {}
function testAuthorize() {

    test:when(mockCheckAdminRole).thenReturn(true);
    boolean|error isAdmin = authorize(mockJWT);
    test:assertEquals(isAdmin, true);
}

