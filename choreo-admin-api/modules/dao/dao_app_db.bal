import ballerina/sql;
import ballerina/io;
import ballerinax/java.jdbc;

// import ballerina/log;
string ADMIN_ROLE = "admin";
public jdbc:Client appDbClient = check createAppDbClient("jdbc:sqlserver://localhost:1433;databaseName=choreo_app_db");

public function checkAdminRole(string idpID, string orgId) returns boolean|error {

    sql:ParameterizedQuery checkAdminQuery = `SELECT role_member_mapping.id From [role_member_mapping] 
        INNER JOIN [user] ON [user].id = [role_member_mapping].user_id 
        INNER JOIN [role] ON [role].id = [role_member_mapping].role_id
        INNER JOIN [organization] ON [role].organization_id = [organization].id 
        WHERE [user].idp_id =${idpID} AND [organization].uuid=${orgId} AND
        [role].handle =${ADMIN_ROLE}`;
    string|sql:Error roleMemberOrgMapping;

    io:println(checkAdminQuery);
    roleMemberOrgMapping = appDbClient->queryRow(checkAdminQuery);

    if roleMemberOrgMapping is string {
        return true;
    } else {
        return roleMemberOrgMapping;
    }
}

function createAppDbClient(string connStr) returns jdbc:Client|error {
    jdbc:Client|sql:Error jdbcClient = check new (url = connStr,
        user = "SA", password = "Admin@123", connectionPool = {maxOpenConnections: 50},
        options = {properties: {"useSSL": true}});
    return jdbcClient;
}
