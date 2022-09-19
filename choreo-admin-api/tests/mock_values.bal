import ballerina/jwt;

// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

string uuidMock = "3ac78213-9cd9-b96a-d98cbb16d4cc";
string handleMock = "choreotestorg";
string billingDateMock = "2021-07-30T10:09:57Z";
string createdAtMock = "2022-04-29T06:30:00Z";
string isPaidMock = "true";
string statusMock = "ACTIVE";
string stepQuotaMock = "1000000";
string tierNameMock = "Enterprise";

public json mockSubscription = {
    "organization": {
        "orgUUID": uuidMock,
        "orgHandle": handleMock
    },
    "billingDate": billingDateMock,
    "createdDate": createdAtMock,
    "paidCustomer": isPaidMock,
    "status": statusMock,
    "stepQuota": stepQuotaMock,
    "tierName": tierNameMock
};

jwt:Payload mockJWTPayload = {"iss": "https://sts.preview-dv.choreo.dev:443/oauth2/token", "sub": "175cfc46-b124-471c-b8ca-f0fd0a8e87bd", "aud": ["Wxqy0liCfLBsdpXOhkcxZz6uLPka", "https://sts.preview-dv.choreo.dev:443/oauth2/token"], "exp": 1663587941, "nbf": 1663584341, "iat": 1663584341, "jti": "fc519261-58c6-4f5b-afa4-f11273cb89eb", "aut": "APPLICATION_USER", "azp": "Wxqy0liCfLBsdpXOhkcxZz6uLPka", "scope": "apim:admin apim:api_manage apim:dcr:app_manage apim:publisher_settings apim:subscription_manage apim:tier_manage choreo:role_manage choreo:user_manage environments:view_dev environments:view_prod", "organization": {"handle": "shanakapremarathna", "uuid": "bea92b4f-545a-4624-95b0-dde815a06af0"}, "organizations": ["bea92b4f-545a-4624-95b0-dde815a06af0", "bc7cf65a-ffa9-4a0b-945e-5410e38b1d37", "783c6c4d-8b9b-4190-b70a-e717ab1ee739"], "idp_claims": {"aut": "APPLICATION_USER", "authenticated_idp": "Google", "name": "Shanaka Premarathna", "given_name": "Shanaka", "family_name": "Premarathna", "email": "shanakap@wso2.com"}};

string mockJWT = "eyJ4NXQiOiJNbUV5WlRSaFpHTTROamc1WW1SbU9XVXlOalkxT1dReVpURXlNREJoTXpVd01ESTFOak5pWlRkalptWXhZMlkzWWpCaU4ySTRaRFppTW1Jek5qYzJPUSIsImtpZCI6Ik1tRXlaVFJoWkdNNE5qZzVZbVJtT1dVeU5qWTFPV1F5WlRFeU1EQmhNelV3TURJMU5qTmlaVGRqWm1ZeFkyWTNZakJpTjJJNFpEWmlNbUl6TmpjMk9RX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIxNzVjZmM0Ni1iMTI0LTQ3MWMtYjhjYS1mMGZkMGE4ZTg3YmQiLCJhdXQiOiJBUFBMSUNBVElPTl9VU0VSIiwiaXNzIjoiaHR0cHM6XC9cL3N0cy5wcmV2aWV3LWR2LmNob3Jlby5kZXY6NDQzXC9vYXV0aDJcL3Rva2VuIiwiYXVkIjpbIld4cXkwbGlDZkxCc2RwWE9oa2N4Wno2dUxQa2EiLCJodHRwczpcL1wvc3RzLnByZXZpZXctZHYuY2hvcmVvLmRldjo0NDNcL29hdXRoMlwvdG9rZW4iXSwibmJmIjoxNjYzNTcwNDg1LCJhenAiOiJXeHF5MGxpQ2ZMQnNkcFhPaGtjeFp6NnVMUGthIiwic2NvcGUiOiJhcGltOmFkbWluIGFwaW06YXBpX21hbmFnZSBhcGltOmRjcjphcHBfbWFuYWdlIGFwaW06cHVibGlzaGVyX3NldHRpbmdzIGFwaW06c3Vic2NyaXB0aW9uX21hbmFnZSBhcGltOnRpZXJfbWFuYWdlIGNob3Jlbzpyb2xlX21hbmFnZSBjaG9yZW86dXNlcl9tYW5hZ2UgZW52aXJvbm1lbnRzOnZpZXdfZGV2IGVudmlyb25tZW50czp2aWV3X3Byb2QiLCJvcmdhbml6YXRpb24iOnsiaGFuZGxlIjoic2hhbmFrYXByZW1hcmF0aG5hIiwidXVpZCI6ImJlYTkyYjRmLTU0NWEtNDYyNC05NWIwLWRkZTgxNWEwNmFmMCJ9LCJvcmdhbml6YXRpb25zIjpbImJlYTkyYjRmLTU0NWEtNDYyNC05NWIwLWRkZTgxNWEwNmFmMCIsImJjN2NmNjVhLWZmYTktNGEwYi05NDVlLTU0MTBlMzhiMWQzNyIsIjc4M2M2YzRkLThiOWItNDE5MC1iNzBhLWU3MTdhYjFlZTczOSJdLCJleHAiOjE2NjM1NzQwODUsImlkcF9jbGFpbXMiOnsiYXV0IjoiQVBQTElDQVRJT05fVVNFUiIsImF1dGhlbnRpY2F0ZWRfaWRwIjoiR29vZ2xlIiwibmFtZSI6IlNoYW5ha2EgUHJlbWFyYXRobmEiLCJnaXZlbl9uYW1lIjoiU2hhbmFrYSIsImZhbWlseV9uYW1lIjoiUHJlbWFyYXRobmEiLCJlbWFpbCI6InNoYW5ha2FwQHdzbzIuY29tIn0sImlhdCI6MTY2MzU3MDQ4NSwianRpIjoiZjIzMTY5ZTAtODUzZi00OGMzLWFmNGEtMWQzN2Q1NTY4NGE5In0.Hu3ED4Fffufr2-ZzaXWpK1WBhccOJZFCo2p3cdm0r0yDrEj9m4z9nCOv8r_c22BD462LZsLgJ804YAeCdaLx02QmYzyY-Uw7ZHF5dA_vVHS3drzHrPkrwQtCwSlnwFEMzIaVeWU244-KRrIXeZe6HomCCEpsTljd0wnHjMNs02FQvntdiGzvkdMLikv6wx69apwisg7wxq09tT9vRsBocWbtpXYPXRYHkNn-dn26qLnSs4qNlhJWfq29ILl_ddblQfbZ4CJl9tVkYLLldsEO8x02xRI-gIm8qCPpPT0crWa-LwBMQQfUXDSk6SWBFxCLlGW74lvJrEDTTt1B3OfDRljnpL4HfnDWtlJor2Sp669OJUNg3midxth2ihSJIL35L2HTXOTBCjDLOc2rn7365bNRvUZEKrTj3bz4QF59EHlFNyRsT0cMrxprF-4GhqPY9NGohdfOzhotXotMRxrX3T3FeBDeKn7tqrUWZiCNYTGsTrr4TP459Y--Mx5otC6PWajZ62jb4KBTX2XEs2epZ2llSh61y0z2IuzLlm04SGPL4886ZPCb1HG_9l2gWz7NWJno1WzSBST45ul5QPW33yfxnkOpznv3YZReMUSbs9cDMxMOI--PhWFlwqsPGr6Js8LhlnHhwgc0twybHyItw8LaXjyrfvPS405TiQOwmGY";
