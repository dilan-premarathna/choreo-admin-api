// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import choreo_admin_api.util;

configurable string ADMIN_ROLE = "admin";

configurable string CHOREO_DB_CONN_STR = util:readFromEnvVar("CHOREO_SUBSCRIPTIONS_DB_URL", "jdbc:sqlserver://host.docker.internal:1433;databaseName=choreo_subscriptions_db");
final string CHOREO_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
final string CHOREO_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");

configurable string CHOREO_APP_DB_CONN_STR = util:readFromEnvVar("CHOREO_SUBSCRIPTIONS_DB_URL", "jdbc:sqlserver://host.docker.internal:1433;databaseName=choreo_app_db");
final string CHOREO_APP_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
final string CHOREO_APP_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");

