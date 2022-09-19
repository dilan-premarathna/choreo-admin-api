// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/http;
import choreo_admin_api.dao;
import ballerina/sql;
import ballerina/log;
import choreo_admin_api.auth;

service http:Service /org on new http:Listener(9090) {

    isolated resource function get subscription/[string orgId](@http:Header {name: "x-forwarded-authorization"} string authorization)
        returns http:Ok|http:InternalServerError|http:NotFound|http:Unauthorized {

        http:Unauthorized? authenticate = auth:authenticate(authorization);

        if authenticate is http:Unauthorized {
            http:Unauthorized err = {body: {"Error": "The provided JWT is invalid. User is not authorized use this API"}};
            log:printError("The provided JWT is invalid. User is not authorized use this API");
            return err;
        }

        boolean|error isAuthorizd = auth:authorize(authorization);
        if isAuthorizd is sql:NoRowsError {
            http:Unauthorized err = {body: {"Error": "User is not authorized use this API"}};
            log:printError("User is not authorized use this API", 'error = isAuthorizd);
            return err;
        } else if isAuthorizd is error {
            http:InternalServerError err = {body: {"Error": "Error occured while authorizing the request"}};
            log:printError("Error occured while authorizing the request", 'error = isAuthorizd);
            return err;
        }

        json|error subsDetail = dao:getOrgSubsctiptionDetails(orgId);
        if subsDetail is json {
            http:Ok ok = {body: subsDetail};
            return ok;
        } else {
            if subsDetail is sql:NoRowsError {
                http:NotFound nf = {body: {"Error": "Unable to find subscription entry to mach the given Organization ID"}};
                log:printError("Unable to find subscription entry for orgUuid: " + orgId);
                return nf;
            }
            http:InternalServerError err = {body: {"Error": "Error occured during retrieving subscription entry"}};
            log:printError("Error occured during retrieving subscription entry", OrganizationId = orgId, 'error = subsDetail);
            return err;
        }

    }

    isolated resource function put subscription/[string orgId](@http:Payload dao:UpdateSubscripionTier subscription,
        @http:Header {name: "x-forwarded-authorization"} string authorization)
        returns http:Ok|http:InternalServerError|http:NotFound|http:Unauthorized {

        http:Unauthorized? authenticate = auth:authenticate(authorization);

        if authenticate is http:Unauthorized {
            http:Unauthorized nf = {body: {"Error": "The provided JWT is invalid. User is not authorized use this API"}};
            log:printError("The provided JWT is invalid. User is not authorized use this API");
            return nf;
        }

        boolean|error isAuthorizd = auth:authorize(authorization);
        if isAuthorizd is sql:NoRowsError {
            http:Unauthorized nf = {body: {"Error": "User is not authorized use this API"}};
            log:printError("User is not authorized use this API", 'error = isAuthorizd);
            return nf;
        } else if isAuthorizd is error {
            http:InternalServerError err = {body: {"Error": "Error occured while authorizing the request"}};
            log:printError("Error occured while authorizing the request", 'error = isAuthorizd);
            return err;
        }

        int|error? status = dao:updateTier(orgId, subscription);
        if status is error {
            http:InternalServerError err = {};
            log:printError("Error occured during subscription update for orgUUID: " + orgId);
            return err;
        } else if (status is int && status == -1) {
            http:NotFound nf = {body: {"Error": "Unable to find subscription entry to mach the given information"}};
            log:printError("Unable to find subscription entry for orgUUID: " + orgId);
            return nf;
        } else {
            json|error updatedSubscription = dao:getOrgSubsctiptionDetails(orgId);
            if (updatedSubscription is json) {
                http:Ok ok = {body: updatedSubscription};
                return ok;
            } else {
                http:InternalServerError err = {};
                log:printError("Error occured during fetching a subscription entry after update operation for orgUUID: ",
                    OrganizationId = orgId, 'error = updatedSubscription);
                return err;
            }
        }
    }
}

