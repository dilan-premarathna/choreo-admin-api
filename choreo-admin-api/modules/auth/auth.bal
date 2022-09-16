import ballerina/jwt;
import choreo_admin_api.dao;
import ballerina/regex;
import ballerina/http;

final http:ListenerJwtAuthHandler choreoAuthHandler = new ({
    issuer: choreoJwtIssuer,
    audience: choreoJwtAudience,
    signatureConfig: {
        jwksConfig: {
            url: choreoJwtJwksUrl
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
    boolean|error isAdminUser = dao:checkAdminRole(idpId, CHOERO_SYS_ORG_ID);
    return isAdminUser;
}

public isolated function authenticate(string jwt) returns http:Unauthorized? {
    string authHeader;
    if jwt.startsWith("Bearer") {
        authHeader = jwt;
    } else {
        authHeader = "Bearer " + jwt;
    }
    jwt:Payload|http:Unauthorized authn = choreoAuthHandler.authenticate(authHeader);
    if authn is http:Unauthorized {
        return authn;
    }
    return;
}
