// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/sql;
import ballerinax/java.jdbc;
import choreo_admin_api.configs;

final jdbc:Client appDbClient = check createAppDbClient();

public isolated function checkAdminRole(string idpID, string orgId) returns boolean|error {

    sql:ParameterizedQuery checkAdminQuery = `SELECT role_member_mapping.id From [role_member_mapping] 
        INNER JOIN [user] ON [user].id = [role_member_mapping].user_id 
        INNER JOIN [role] ON [role].id = [role_member_mapping].role_id
        INNER JOIN [organization] ON [role].organization_id = [organization].id 
        WHERE [user].idp_id =${idpID} AND [organization].uuid=${orgId} AND
        [role].handle =${configs:ADMIN_ROLE}`;
    string|sql:Error roleMemberOrgMapping;

    roleMemberOrgMapping = appDbClient->queryRow(checkAdminQuery);

    if roleMemberOrgMapping is string {
        return true;
    } else {
        return roleMemberOrgMapping;
    }
}

function createAppDbClient() returns jdbc:Client|error {
    jdbc:Client|sql:Error jdbcClient = check new (url = configs:CHOREO_APP_DB_CONN_STR,
        user = configs:CHOREO_APP_DB_USERNAME, password = configs:CHOREO_APP_DB_PASSWORD, connectionPool = {maxOpenConnections: 50},
        options = {properties: {"useSSL": true}});
    return jdbcClient;
}
