import choreo_admin_api.util;

final string ADMIN_ROLE = "admin";

configurable string CHOREO_DB_CONN_STR = util:readFromEnvVar("CHOREO_SUBSCRIPTIONS_DB_URL", "jdbc:sqlserver://localhost:1433;databaseName=choreo_subscriptions_db");
configurable string CHOREO_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
configurable string CHOREO_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");

configurable string CHOREO_APP_DB_CONN_STR = util:readFromEnvVar("CHOREO_SUBSCRIPTIONS_DB_URL", "jdbc:sqlserver://localhost:1433;databaseName=choreo_app_db");
configurable string CHOREO_APP_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
configurable string CHOREO_APP_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");
