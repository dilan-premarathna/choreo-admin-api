// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import choreo_admin_api.util;

public const string ADMIN_ROLE = "admin";

public string CHOREO_DB_CONN_STR = util:readFromEnvVar("CHOREO_SUBSCRIPTIONS_DB_URL", "jdbc:sqlserver://localhost:1433;databaseName=choreo_subscriptions_db");
public final string CHOREO_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
public final string CHOREO_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");

public string CHOREO_APP_DB_CONN_STR = util:readFromEnvVar("CHOREO_SUBSCRIPTIONS_DB_URL", "jdbc:sqlserver://localhost:1433;databaseName=choreo_app_db");
public final string CHOREO_APP_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
public final string CHOREO_APP_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");

public final string CHOERO_SYS_ORG_UUID = util:readFromEnvVar("CHOERO_SYS_ORG_UUID", "bea92b4f-545a-4624-95b0-dde815a06af0");
public final string choreoJwtIssuer = util:readFromEnvVar("CHOREO_JWT_ISSUER",
        "https://sts.preview-dv.choreo.dev:443/oauth2/token");
public final string choreoJwtAudience = util:readFromEnvVar("CHOREO_JWT_AUDIENCE", "Wxqy0liCfLBsdpXOhkcxZz6uLPka");
public final string choreoJwtJwksUrl = util:readFromEnvVar("CHOREO_JWT_JWKS_URL",
        "https://sts.preview-dv.choreo.dev/oauth2/jwks");
