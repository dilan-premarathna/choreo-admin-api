import ballerina/jwt;
import choreo_admin_api.dao;
import ballerina/regex;

configurable string choreoSysOrgID = "bea92b4f-545a-4624-95b0-dde815a06af0";

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
    boolean|error isAdminUser = dao:checkAdminRole(idpId, choreoSysOrgID);
    return isAdminUser;
}
