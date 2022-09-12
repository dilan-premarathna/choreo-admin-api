import choreo_admin_api.util;

configurable string CONN_STR = util:readFromEnvVar("CONN_STR", "jdbc:sqlserver://localhost:1433;databaseName=choreo_subscriptions_db");
configurable string CHOREO_DB_USERNAME = util:readFromEnvVar("CHOREO_DB_USERNAME", "SA");
configurable string CHOREO_DB_PASSWORD = util:readFromEnvVar("CHOREO_DB_PASSWORD", "Admin@123");

