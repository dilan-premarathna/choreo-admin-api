// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/http;
import choreo_admin_api.health;

service / on new http:Listener(9093) {

    isolated resource function get liveness() returns json {
        return {status: "OK"};
    }

    isolated resource function get readiness() returns json {
        http:Response res = new;
        res.statusCode = health:getOverallHealthStatus();
        if (res.statusCode == http:STATUS_OK) {
            return {status: "OK"};
        } else {
            return {status: "ERROR"};
        }
    }
}
