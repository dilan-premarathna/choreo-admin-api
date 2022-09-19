// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/jwt;
import choreo_admin_api.dao;
import ballerina/regex;
import ballerina/http;
import choreo_admin_api.configs;

final http:ListenerJwtAuthHandler choreoAuthHandler = new ({
    issuer: configs:choreoJwtIssuer,
    audience: configs:choreoJwtAudience,
    signatureConfig: {
        jwksConfig: {
            url: configs:choreoJwtJwksUrl
        }
    }
});

isolated function getIdpID(string jwt) returns error|string {
    string token;
    if jwt.startsWith("Bearer") {
        token = regex:split(jwt, " ")[1];
    } else {
        token = jwt;
    }
    [jwt:Header, jwt:Payload] [_, payload] = check jwt:decode(token);

    if payload.sub != null && payload.sub != "" {
        return <string>payload.sub;
    } else {
        return error("Empty subject in the provided JWT");
    }

}

public isolated function authorize(string jwt) returns boolean|error {
    string idpId = check getIdpID(jwt);
    boolean|error isAdminUser = dao:checkAdminRole(idpId, configs:CHOERO_SYS_ORG_UUID);

    return isAdminUser;
}

public isolated function authenticate(string jwt) returns jwt:Payload|http:Unauthorized {
    string authHeader;
    if jwt.startsWith("Bearer") {
        authHeader = jwt;
    } else {
        authHeader = "Bearer " + jwt;
    }
    jwt:Payload|http:Unauthorized auth = choreoAuthHandler.authenticate(authHeader);

    return auth;
}
